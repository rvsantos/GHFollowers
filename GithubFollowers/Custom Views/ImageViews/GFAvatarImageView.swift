//
//  GFAvatarImageView.swift
//  GithubFollowers
//
//  Created by Rafael V. dos Santos on 15/11/20.
//

import UIKit

class GFAvatarImageView: UIImageView {

    //MARK:- Properties
    let placeholderImage    = UIImage(named: "avatar-placeholder")!
    
    //MARK:- Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- Private
    private func configure() {
        layer.cornerRadius  = 10
        clipsToBounds       = true
        image               = self.placeholderImage
        translatesAutoresizingMaskIntoConstraints = false
    }
}
