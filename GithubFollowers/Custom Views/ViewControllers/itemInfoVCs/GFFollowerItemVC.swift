//
//  GFFollowerItemVC.swift
//  GithubFollowers
//
//  Created by Rafael V. dos Santos on 19/11/20.
//

import Foundation

protocol GFFollowerItemVCDelegate: class {
    func didTapGetFollowers(for user: User)
}

class GFFollowerItemVC: GFItemInfoVC {
    
    //MARK:- Properties
    weak var delegate: GFFollowerItemVCDelegate!
    
    //MARK:- Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureItems()
    }
    
    
    init(user: User, delegate: GFFollowerItemVCDelegate) {
        super.init(user: user)
        self.delegate   = delegate
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK:- Helpers
    private func configureItems() {
        self.itemInfoViewOne.set(itemInfoType: .followers, withCount: self.user.followers)
        self.itemInfoViewTwo.set(itemInfoType: .following, withCount: self.user.following)
        self.actionButton.set(backgroundColor: .systemGreen, title: "Get Followers")
    }
    
    
    override func actionButtonTapped() {
        self.delegate.didTapGetFollowers(for: self.user)
    }
}
