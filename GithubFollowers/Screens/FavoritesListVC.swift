//
//  FavoritesListVC.swift
//  GithubFollowers
//
//  Created by Rafael V. dos Santos on 12/11/20.
//

import UIKit

class FavoritesListVC: UIViewController {
    
    //MARK:- Properties
    let tableView               = UITableView()
    var favorites: [Follower]   = []
    
    //MARK:- Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configure()
        self.configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.getFavorites()
    }
    
    //MARK:- Helpers
    private func configure() {
        self.view.backgroundColor   = .systemBackground
        title                       = "Favorites"
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func configureTableView() {
        view.addSubview(self.tableView)
        
        self.tableView.frame        = self.view.bounds
        self.tableView.rowHeight    = 80
        self.tableView.delegate     = self
        self.tableView.dataSource   = self
        
        self.tableView.register(FavoriteCell.self, forCellReuseIdentifier: FavoriteCell.reuseID)
    }
    
    private func getFavorites() {
        PersistenceManager.retriveFavorites { [weak self] (result) in
            guard let self = self else {return}
            
            switch result {
            case .success(let favorites):
                if favorites.isEmpty {
                    self.showEmptyStateView(
                        with: "No favorites?\nAdd one on the follower screen",
                        in: self.view)
                } else {
                    self.favorites = favorites
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                        self.view.bringSubviewToFront(self.tableView)
                    }
                }

            case .failure(let error):
                self.presentGFAlertOnMainThread(
                    title: "Something went wrong",
                    message: error.rawValue,
                    buttonTitle: "Ok")
            }
        }
    }
}

extension FavoritesListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteCell.reuseID) as! FavoriteCell
        
        cell.set(favorite: self.favorites[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let favorite    = self.favorites[indexPath.row]
        let destVC      = FollowerListVC()
        destVC.title    = favorite.login
        destVC.set(username: favorite.login)
        
        navigationController?.pushViewController(destVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else {return}
        
        let favorite = self.favorites[indexPath.row]
        self.favorites.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .left)
        
        PersistenceManager.updateWith(favorite: favorite, actionType: .remove) { [weak self] (error) in
            guard let self = self else { return }
            guard let error = error else { return }
            self.presentGFAlertOnMainThread(title: "Unable to remove", message: error.rawValue, buttonTitle: "Ok ")
        }
    }
}
