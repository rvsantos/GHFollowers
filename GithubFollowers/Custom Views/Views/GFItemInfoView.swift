//
//  GFItemInfoView.swift
//  GithubFollowers
//
//  Created by Rafael V. dos Santos on 19/11/20.
//

import UIKit

enum ItemmInfoType {
    case repos, gists, followers, following
}

class GFItemInfoView: UIView {

    //MARK:- Properties
    private let symbolImageView     = UIImageView()
    private let titleLabel          = GFTitleLabel(textAlignment: .center, fontSize: 14)
    private let countLabel          = GFTitleLabel(textAlignment: .center, fontSize: 14)
    
    //MARK:- Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- Helpers
    private func configure() {
        addSubview(self.symbolImageView)
        addSubview(self.titleLabel)
        addSubview(self.countLabel)
        
        self.symbolImageView.translatesAutoresizingMaskIntoConstraints = false
        self.symbolImageView.contentMode    = .scaleAspectFill
        self.symbolImageView.tintColor      = .label
        
        NSLayoutConstraint.activate([
            self.symbolImageView.topAnchor.constraint(equalTo: self.topAnchor),
            self.symbolImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.symbolImageView.heightAnchor.constraint(equalToConstant: 20),
            self.symbolImageView.widthAnchor.constraint(equalToConstant: 20),
            
            self.titleLabel.centerYAnchor.constraint(equalTo: self.symbolImageView.centerYAnchor),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.symbolImageView.trailingAnchor, constant: 12),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.titleLabel.heightAnchor.constraint(equalToConstant: 18),
            
            self.countLabel.topAnchor.constraint(equalTo: self.symbolImageView.bottomAnchor, constant: 4),
            self.countLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.countLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.countLabel.heightAnchor.constraint(equalToConstant: 18),
        ])
    }
    
    func set(itemInfoType: ItemmInfoType, withCount count: Int) {
        switch itemInfoType {
        case .repos:
            self.symbolImageView.image  = UIImage(systemName: SFSymbols.repos)
            self.titleLabel.text        = "Public Repos"
        case .gists:
            self.symbolImageView.image  = UIImage(systemName: SFSymbols.gists)
            self.titleLabel.text        = "Public Gists"
        case .followers:
            self.symbolImageView.image  = UIImage(systemName: SFSymbols.followers)
            self.titleLabel.text        = "Followers"
        case .following:
            self.symbolImageView.image  = UIImage(systemName: SFSymbols.following)
            self.titleLabel.text        = "Following"
        }
        
        self.countLabel.text            = String(count)
    }
    
}
