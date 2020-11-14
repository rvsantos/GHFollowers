//
//  BaseViewController.swift
//  GithubFollowers
//
//  Created by Rafael V. dos Santos on 12/11/20.
//

import UIKit

class BaseViewController: UIViewController {

    // MARK: - Variables
    static let shared = BaseViewController()
    var tabbar: UITabBarController {
        return self.createTabBar()
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Helpers
    private func createTabBar() -> UITabBarController {
        self.configureNavigationBar()
        
        let tabbar = UITabBarController()
        UITabBar.appearance().tintColor = .systemGreen
        tabbar.viewControllers = [self.createSearchNC(), self.createFavoritesNC()]
        return tabbar
    }
    
    // MARK: - Private
    private func createSearchNC() -> UINavigationController {
        let searchVC = SearchVC()
        searchVC.title = "Search"
        searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        return UINavigationController(rootViewController: searchVC)
    }
    
    private func createFavoritesNC() -> UINavigationController {
        let favoritesListVC = FavoritesListVC()
        favoritesListVC.title = "Favorites"
        favoritesListVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        return UINavigationController(rootViewController: favoritesListVC)
    }

    private func configureNavigationBar() {
        UINavigationBar.appearance().tintColor = .systemGreen
    }
}
