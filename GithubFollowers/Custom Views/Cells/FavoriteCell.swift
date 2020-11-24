//
//  FavoriteCell.swift
//  GithubFollowers
//
//  Created by Rafael V. dos Santos on 23/11/20.
//

import UIKit

class FavoriteCell: UITableViewCell {

    //MARK:- Identifier
    static let reuseID = "FavoriteCell"
    
    //MARK:- Components
    let avatarImageView = GFAvatarImageView(frame: .zero)
    let usernameLabel   = GFTitleLabel(textAlignment: .left, fontSize: 26)
    
    //MARK:- Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- Helpers
    func set(favorite: Follower) {
        self.usernameLabel.text = favorite.login
        self.avatarImageView.downloadImage(from: favorite.avatarUrl)
    }
    
    private func configure() {
        addSubview(self.avatarImageView)
        addSubview(self.usernameLabel)
        
        accessoryType           = .disclosureIndicator
        let padding: CGFloat    = 12
        
        NSLayoutConstraint.activate([
            self.avatarImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.avatarImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            self.avatarImageView.heightAnchor.constraint(equalToConstant: 60),
            self.avatarImageView.widthAnchor.constraint(equalToConstant: 60),
            
            self.usernameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.usernameLabel.leadingAnchor.constraint(equalTo: self.avatarImageView.trailingAnchor, constant: 24),
            self.usernameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            self.usernameLabel.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
}
