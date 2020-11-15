//
//  FollowerListVC.swift
//  GithubFollowers
//
//  Created by Rafael V. dos Santos on 12/11/20.
//

import UIKit

class FollowerListVC: UIViewController {

    //MARK:- Variables
    var username: String!
    
    
    //MARK:- Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        NetworkManager.shared.getFollowers(for: username, page: 1) { (followers, errorMessage) in
            guard let followers = followers else {
                self.presentGFAlertOnMainThread(title: "Bad Stuff Happend",
                                                message: errorMessage!.rawValue,
                                                buttonTitle: "Ok")
                return
            }
            
            print("followers.count: \(followers.count)")
            print(followers)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
}
