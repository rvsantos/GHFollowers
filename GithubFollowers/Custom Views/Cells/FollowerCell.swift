//
//  FollowerCell.swift
//  GithubFollowers
//
//  Created by Rafael V. dos Santos on 15/11/20.
//

import UIKit

class FollowerCell: UICollectionViewCell {
    
    //MARK:- Identifier
    static let reuseID = "FollowerCell"
    
    //MARK:- Components
    private let avatarImageView = GFAvatarImageView(frame: .zero)
    private let usernameLabel   = GFTitleLabel(textAlignment: .center, fontSize: 16)
    
    
    //MARK:- Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK:- Private
    func set(follower: Follower) {
        self.usernameLabel.text = follower.login
        self.avatarImageView.downloadImage(fromURL: follower.avatarUrl)
    }
    
    
    private func configure() {
        addSubViews(
            self.avatarImageView,
            self.usernameLabel
        )
        
        let padding: CGFloat = 8
        
        NSLayoutConstraint.activate([
            self.avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            self.avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            self.avatarImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            self.avatarImageView.heightAnchor.constraint(equalTo: self.avatarImageView.widthAnchor),
            
            self.usernameLabel.topAnchor.constraint(equalTo: self.avatarImageView.bottomAnchor, constant: 12),
            self.usernameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            self.usernameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            self.usernameLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
}
