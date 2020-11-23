//
//  GFReposItemVC.swift
//  GithubFollowers
//
//  Created by Rafael V. dos Santos on 19/11/20.
//

import Foundation

class GFRepoItemVC: GFItemInfoVC {
    
    //MARK:- Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureItems()
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
