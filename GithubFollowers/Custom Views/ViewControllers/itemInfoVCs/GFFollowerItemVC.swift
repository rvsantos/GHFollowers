//
//  GFFollowerItemVC.swift
//  GithubFollowers
//
//  Created by Rafael V. dos Santos on 19/11/20.
//

import Foundation

class GFFollowerItemVC: GFItemInfoVC {
    
    //MARK:- Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureItems()
    }
    
    //MARK:- Helpers
    private func configureItems() {
        self.itemInfoViewOne.set(itemInfoType: .followers, withCount: self.user.followers)
        self.itemInfoViewTwo.set(itemInfoType: .following, withCount: self.user.following)
        self.actionButton.set(backgroundColor: .systemGreen, title: "Get Followers")
    }
}
