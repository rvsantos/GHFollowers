//
//  UserInfoVC.swift
//  GithubFollowers
//
//  Created by Rafael V. dos Santos on 16/11/20.
//

import UIKit

protocol UserInfoVCDelegate: class {
    func didTapGitHubProfile(for user: User)
    func didTapGetFollowers(for user: User)
}

class UserInfoVC: UIViewController {

    // MARK: - Properties
    private var username: String?
    private let headerView          = UIView()
    private let itemViewOne         = UIView()
    private let itemViewTwo         = UIView()
    private let dateLabel           = GFBodyLabel(textAlignment: .center)
    private var itemViews: [UIView] = []
    
    weak var delegate: FollowerListVCDelegate!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.configureViewController()
        self.layoutUI()
        self.get(user: self.username!)
    }
    
    // MARK: - Helpers
    func set(username: String) {
        self.username = username
    }
    
    private func layoutUI() {
        let padding: CGFloat    = 20
        let itemHeigth: CGFloat = 140
        
        self.itemViews = [self.headerView, self.itemViewOne, self.itemViewTwo, self.dateLabel]
        
        for itemView in self.itemViews {
            self.view.addSubview(itemView)
            itemView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                itemView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: padding),
                itemView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -padding),
            ])
        }
        
        NSLayoutConstraint.activate([
            self.headerView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.headerView.heightAnchor.constraint(equalToConstant: 180),
            
            self.itemViewOne.topAnchor.constraint(equalTo: self.headerView.bottomAnchor, constant: 40),
            self.itemViewOne.heightAnchor.constraint(equalToConstant: itemHeigth),
            
            self.itemViewTwo.topAnchor.constraint(equalTo: self.itemViewOne.bottomAnchor, constant: padding),
            self.itemViewTwo.heightAnchor.constraint(equalToConstant: itemHeigth),
            
            self.dateLabel.topAnchor.constraint(equalTo: self.itemViewTwo.bottomAnchor, constant: padding),
            self.dateLabel.heightAnchor.constraint(equalToConstant: 18),
        ])
    }
    
    private func configureViewController() {
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        self.navigationItem.rightBarButtonItem = doneButton
    }
    
    private func add(childVC: UIViewController, to containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
    
    private func get(user: String) {
        NetworkManager.shared.getUserInfo(for: user) { [weak self] (result) in
            guard let self = self else { return }
            
            switch result {
            case .success(let user):
                DispatchQueue.main.async { self.configureUIElements(with: user) }
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    private func configureUIElements(with user: User) {
        let repoItemVC          = GFRepoItemVC(user: user)
        repoItemVC.delegate     = self
        
        let followerItemVC      = GFFollowerItemVC(user: user)
        followerItemVC.delegate = self
        
        self.add(childVC: GFUserInfoHeaderVC(user: user), to: self.headerView)
        self.add(childVC: repoItemVC, to: self.itemViewOne)
        self.add(childVC: followerItemVC, to: self.itemViewTwo)
        self.dateLabel.text = "Github since \(user.createdAt.convertToDisplayFormat())"
    }
    
    // MARK: - @objc
    @objc private func dismissVC() {
        self.dismiss(animated: true, completion: nil)
    }
}

extension UserInfoVC: UserInfoVCDelegate {
    func didTapGitHubProfile(for user: User) {
        guard let url = URL(string: user.htmlUrl) else {
            self.presentGFAlertOnMainThread(
                title: "Invalid URL",
                message: "The url attached to this user is invalid",
                buttonTitle: "Ok")
            return
        }
        
        self.presentSafariVC(with: url)
    }
    
    func didTapGetFollowers(for user: User) {
        guard user.followers != 0 else {
            self.presentGFAlertOnMainThread(
                title: "No followers",
                message: "This user has no followers.",
                buttonTitle: "So sad")
            
            return
        }
        
        self.delegate.didRequestFollowers(for: user.login)
        self.dismissVC()
    }
}
