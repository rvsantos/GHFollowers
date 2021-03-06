//
//  FollowerListVC.swift
//  GithubFollowers
//
//  Created by Rafael V. dos Santos on 12/11/20.
//

import UIKit

class FollowerListVC: GFDataLoadingVC {

    enum Section { case main }
    
    //MARK:- Variables
    private var username: String!
    private var followers: [Follower]           = []
    private var filteredFollowers: [Follower]   = []
    private var page                            = 1
    private var hasMoreFollowers                = true
    private var isSearching                     = false
    private var isLoadingMoreFollowers          = false
    
    private var collectionView: UICollectionView!
    private var dataSource:     UICollectionViewDiffableDataSource<Section, Follower>!
    
    
    //MARK:- Lifecycle
    init(username: String) {
        super.init(nibName: nil, bundle: nil)
        
        self.username   = username
        title           = username
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.configureViewController()
        self.configureSearchController()
        self.configureColletionView()
        self.configureDataSource()
        self.getFollowers(username: self.username, page: self.page)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    //MARK:- Private
    private func configureViewController() {
        self.view.backgroundColor = .systemBackground
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        self.navigationItem.rightBarButtonItem = addButton
    }
    
    
    private func configureColletionView() {
        self.collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: view))
        view.addSubview(self.collectionView)
        self.collectionView.delegate        = self
        self.collectionView.backgroundColor = .systemBackground
        self.collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
    }
    
    
    private func configureSearchController() {
        let searchController                                    = UISearchController()
        searchController.searchResultsUpdater                   = self
        searchController.searchBar.placeholder                  = "Search for a username"
        searchController.obscuresBackgroundDuringPresentation   = false
        self.navigationItem.searchController                    = searchController
    }
    
    
    private func configureDataSource() {
        self.dataSource = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: self.collectionView, cellProvider: { (collectionView, indexPath, follower) -> UICollectionViewCell? in
            let cell: FollowerCell? = collectionView
                .dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseID, for: indexPath) as? FollowerCell
            
            cell?.set(follower: follower)
            
            return cell
        })
    }

    
    private func updateData(on followers: [Follower]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        
        DispatchQueue.main.async { self.dataSource.apply(snapshot, animatingDifferences: true) }
    }
    
    
    private func getFollowers(username: String, page: Int) {
        self.showLoadingView()
        self.isLoadingMoreFollowers = true
        
        NetworkManager.shared.getFollowers(for: username, page: page) { [weak self] result in
            guard let self = self else { return }
            self.dismissLoadingView()
            
            switch result {
            case .success(let followers):
                self.updateUI(with: followers)
                
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Bad Stuff Happend", message: error.rawValue, buttonTitle: "Ok")
            }
            
            self.isLoadingMoreFollowers = false
        }
    }
    
    
    private func updateUI(with followers: [Follower]) {
        if followers.count < 100 { self.hasMoreFollowers = false }
        self.followers.append(contentsOf: followers)
        
        if self.followers.isEmpty {
            let message = "This user doesn't have any followers. Go follow them 😋."
            DispatchQueue.main.async { self.showEmptyStateView(with: message, in: self.view) }
            return
        }
        
        self.updateData(on: self.followers)
    }
    
    
    private func addUserToFavorites(user: User) {
        let favorite = Follower(login: user.login, avatarUrl: user.avatarUrl)
        PersistenceManager.updateWith(favorite: favorite, actionType: .add) { [weak self] (error) in
            guard let self = self else {return}
            
            guard let error = error else {
                self.presentGFAlertOnMainThread(
                    title: "Success",
                    message: "You have successfully favorited this user.",
                    buttonTitle: "Ok")
                
                return
            }
            
            self.presentGFAlertOnMainThread(
                title: "Something went wrong",
                message: error.rawValue,
                buttonTitle: "Ok")
        }
    }


    // MARK:- Selectors
    @objc func addButtonTapped() {
        showLoadingView()
        
        NetworkManager.shared.getUserInfo(for: self.username) { [weak self] (result) in
            guard let self = self else {return}
            self.dismissLoadingView()
            
            switch result {
            case .success(let user):
                self.addUserToFavorites(user: user)
                
            case .failure(let error):
                self.presentGFAlertOnMainThread(
                    title: "Something went wrong",
                    message: error.rawValue,
                    buttonTitle: "Ok")
            }
        }
    }
}


// MARK:- Extension UICollectionViewDelegate
extension FollowerListVC: UICollectionViewDelegate {
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY         = scrollView.contentOffset.y
        let contentHeight   = scrollView.contentSize.height
        let height          = scrollView.frame.size.height
        
        if offsetY > (contentHeight - height) {
            guard self.hasMoreFollowers, !self.isLoadingMoreFollowers else { return }
            self.page += 1
            self.getFollowers(username: self.username, page: self.page)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let follower    = self.isSearching ? self.filteredFollowers[indexPath.item] : self.followers[indexPath.item]
        let userInfoVC  = UserInfoVC()
        userInfoVC.set(username: follower.login)
        userInfoVC.delegate = self
        let navController   = UINavigationController(rootViewController: userInfoVC)
        
        self.present(navController, animated: true, completion: nil)
    }
}


// MARK:- Extension UISearchResultsUpdating
extension FollowerListVC: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else {
            self.filteredFollowers.removeAll()
            self.updateData(on: self.followers)
            self.isSearching = false
            return
        }
        
        self.isSearching        = true
        self.filteredFollowers  = self.followers.filter { $0.login.lowercased().contains(filter.lowercased())}
        self.updateData(on: self.filteredFollowers)
    }
}


// MARK:- Extension UserInfoVCDelegate
extension FollowerListVC: UserInfoVCDelegate {
    
    func didRequestFollowers(for username: String) {
        title           = username
        self.username   = username
        self.page       = 1
        
        self.followers.removeAll()
        self.filteredFollowers.removeAll()
        self.collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
        self.getFollowers(username: username, page: page)
    }
}
