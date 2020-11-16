//
//  GFEmptyStateView.swift
//  GithubFollowers
//
//  Created by Rafael V. dos Santos on 16/11/20.
//

import UIKit

class GFEmptyStateView: UIView {

    //MARK:- Components
    let message         = GFTitleLabel(textAlignment: .center, fontSize: 28)
    let logoImageView   = UIImageView()
    
    //MARK:- Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(message: String) {
        super.init(frame: .zero)
        self.message.text = message
        self.configure()
    }
    
    //MARK:- Private
    private func configure() {
        addSubview(self.message)
        self.message.numberOfLines  = 3
        self.message.textColor      = .secondaryLabel
        self.message.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(self.logoImageView)
        self.logoImageView.image    = UIImage(named: "empty-state-logo")
        self.logoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.message.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -150),
            self.message.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40),
            self.message.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
            self.message.heightAnchor.constraint(equalToConstant: 200),
            
            self.logoImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
            self.logoImageView.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
            self.logoImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 170),
            self.logoImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 40),
        ])
    }
    
}
