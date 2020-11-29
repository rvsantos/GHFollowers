//
//  GFAvatarImageView.swift
//  GithubFollowers
//
//  Created by Rafael V. dos Santos on 15/11/20.
//

import UIKit

class GFAvatarImageView: UIImageView {

    //MARK:- Properties
    let placeholderImage    = Images.placeholder
    
    
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
    
    
    //MARK:- Helpers
    func downloadImage(fromURL url: String) {
        NetworkManager.shared.downloadImage(from: url) { [weak self] (image) in
            guard let self = self else { return }
            DispatchQueue.main.async { self.image = image  }
        }
    }
}
