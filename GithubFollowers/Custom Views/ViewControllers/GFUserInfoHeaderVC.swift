//
//  GFUserInfoHeaderVC.swift
//  GithubFollowers
//
//  Created by Rafael V. dos Santos on 17/11/20.
//

import UIKit

class GFUserInfoHeaderVC: UIViewController {

    // MARK: - Properties
    let avatarImageView     = GFAvatarImageView(frame: .zero)
    let usernameLabel       = GFTitleLabel(textAlignment: .left, fontSize: 34)
    let nameLabel           = GFSecondaryTitleLabel(fontSize: 18)
    let locationImageView   = UIImageView()
    let locationLabel       = GFSecondaryTitleLabel(fontSize: 18)
    let bioLabel            = GFBodyLabel(textAlignment: .left)
    
    var user: User!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addSubiew()
        self.layoutUI()
        self.configureUIElements()
    }
    
    // MARK: - Initialization
    init(user: User) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    private func configureUIElements() {
        self.downloadAvatarImage(from: self.user, in: self.avatarImageView)
        self.usernameLabel.text             = self.user.login
        self.nameLabel.text                 = self.user.name ?? ""
        self.locationLabel.text             = self.user.location ?? "No Location"
        self.bioLabel.text                  = self.user.bio ?? "No bio available"
        self.bioLabel.numberOfLines         = 3
        
        self.locationImageView.image        = SFSymbols.location
        self.locationImageView.tintColor    = .secondaryLabel
    }
    
    private func downloadAvatarImage(from user: User, in avatar: UIImageView) {
        NetworkManager.shared.downloadImage(from: user.avatarUrl) { [weak self] (image) in
            guard let _ = self else { return }
            DispatchQueue.main.async { avatar.image = image  }
        }
    }
    
    private func addSubiew() {
        view.addSubViews(
            self.avatarImageView,
            self.usernameLabel,
            self.nameLabel,
            self.locationImageView,
            self.locationLabel,
            self.bioLabel
        )
    }
    
    private func layoutUI() {
        let padding: CGFloat            = 20
        let textImagePadding: CGFloat   = 12
        self.locationImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.avatarImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            self.avatarImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            self.avatarImageView.widthAnchor.constraint(equalToConstant: 90),
            self.avatarImageView.heightAnchor.constraint(equalToConstant: 90),
            
            self.usernameLabel.topAnchor.constraint(equalTo: self.avatarImageView.topAnchor),
            self.usernameLabel.leadingAnchor.constraint(equalTo: self.avatarImageView.trailingAnchor, constant: textImagePadding),
            self.usernameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            self.usernameLabel.heightAnchor.constraint(equalToConstant: 38),
            
            self.nameLabel.centerYAnchor.constraint(equalTo: self.avatarImageView.centerYAnchor, constant: 8),
            self.nameLabel.leadingAnchor.constraint(equalTo: self.avatarImageView.trailingAnchor, constant: textImagePadding),
            self.nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            self.nameLabel.heightAnchor.constraint(equalToConstant: 20),
            
            self.locationImageView.bottomAnchor.constraint(equalTo: self.avatarImageView.bottomAnchor),
            self.locationImageView.leadingAnchor.constraint(equalTo: self.avatarImageView.trailingAnchor, constant: textImagePadding),
            self.locationImageView.widthAnchor.constraint(equalToConstant: 20),
            self.locationImageView.heightAnchor.constraint(equalToConstant: 20),
            
            self.locationLabel.centerYAnchor.constraint(equalTo: self.locationImageView.centerYAnchor),
            self.locationLabel.leadingAnchor.constraint(equalTo: self.locationImageView.trailingAnchor, constant: 5),
            self.locationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            self.locationLabel.heightAnchor.constraint(equalToConstant: 20),
            
            self.bioLabel.topAnchor.constraint(equalTo: self.avatarImageView.bottomAnchor, constant: textImagePadding),
            self.bioLabel.leadingAnchor.constraint(equalTo: self.avatarImageView.leadingAnchor),
            self.bioLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            self.bioLabel.heightAnchor.constraint(equalToConstant: 90),
        ])
    }
}
