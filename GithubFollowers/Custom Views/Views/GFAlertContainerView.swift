//
//  GFAlertContainerView.swift
//  GithubFollowers
//
//  Created by Rafael V. dos Santos on 24/11/20.
//

import UIKit

class GFAlertContainerView: UIView {

    //MARK:- Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK:- Helpers
    private func configure() {
        backgroundColor      = .systemBackground
        layer.cornerRadius   = 16
        layer.borderWidth    = 2
        layer.borderColor    = UIColor.white.cgColor
        translatesAutoresizingMaskIntoConstraints = false
    }
}
