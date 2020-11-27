//
//  GFReposItemVC.swift
//  GithubFollowers
//
//  Created by Rafael V. dos Santos on 19/11/20.
//

import Foundation

protocol GFRepoItemVCDelegate: class {
    func didTapGitHubProfile(for user: User)
}

class GFRepoItemVC: GFItemInfoVC {
    
    //MARK:- Properties
    weak var delegate: GFRepoItemVCDelegate!
    
    //MARK:- Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureItems()
    }
    
    init(user: User, delegate: GFRepoItemVCDelegate) {
        super.init(user: user)
        self.delegate   = delegate
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- Helpers
    private func configureItems() {
        self.itemInfoViewOne.set(itemInfoType: .repos, withCount: self.user.publicRepos)
        self.itemInfoViewTwo.set(itemInfoType: .gists, withCount: self.user.publicGists)
        self.actionButton.set(backgroundColor: .systemPurple, title: "Github Profile")
    }
    
    override func actionButtonTapped() {
        self.delegate.didTapGitHubProfile(for: self.user)
    }
}
