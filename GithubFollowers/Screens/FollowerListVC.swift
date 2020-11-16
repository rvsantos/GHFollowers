//
//  FollowerListVC.swift
//  GithubFollowers
//
//  Created by Rafael V. dos Santos on 12/11/20.
//

import UIKit

class FollowerListVC: UIViewController {

    enum Section { case main }
    
    //MARK:- Variables
    var username:       String!
    var followers:      [Follower] = []
    
    var collectionView: UICollectionView!
    var dataSource:     UICollectionViewDiffableDataSource<Section, Follower>!
    
    //MARK:- Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.configureViewController()
        self.configureColletionView()
        self.configureDataSource()
        self.getFollowers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    //MARK:- Private
    private func configureViewController() {
        self.view.backgroundColor = .systemBackground
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func configureColletionView() {
        self.collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: view))
        self.view.addSubview(self.collectionView)
        self.collectionView.backgroundColor = .systemBackground
        self.collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
    }
    
    private func configureDataSource() {
        self.dataSource = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: self.collectionView, cellProvider: { (collectionView, indexPath, follower) -> UICollectionViewCell? in
            let cell: FollowerCell? = collectionView
                .dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseID, for: indexPath) as? FollowerCell
            
            cell?.set(follower: follower)
            
            return cell
        })
    }
    
    private func updateData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(self.followers)
        
        DispatchQueue.main.async { self.dataSource.apply(snapshot, animatingDifferences: true) }
    }
    
    private func getFollowers() {
        NetworkManager.shared.getFollowers(for: username, page: 1) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let followers):
                self.followers = followers
                self.updateData()
                
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Bad Stuff Happend", message: error.rawValue, buttonTitle: "Ok")
            }
        }

    }
}
