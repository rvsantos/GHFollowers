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
    
    
    convenience init(message: String) {
        self.init(frame: .zero)
        self.message.text = message
    }
    
    
    //MARK:- Private
    private func configure() {
        addSubViews(self.message, self.logoImageView)
        self.configureMessageLabel()
        self.configureLogoImageView()
    }
    
    
    private func configureMessageLabel() {
        self.message.numberOfLines  = 3
        self.message.textColor      = .secondaryLabel
        self.message.translatesAutoresizingMaskIntoConstraints = false
        
        let labelCenterYConstant: CGFloat = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? -80 : -150
        
        NSLayoutConstraint.activate([
            self.message.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: labelCenterYConstant),
            self.message.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40),
            self.message.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
            self.message.heightAnchor.constraint(equalToConstant: 200),
            
        ])
    }
    
    
    private func configureLogoImageView() {
        self.logoImageView.image    = Images.emptyStateLogo
        self.logoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let logoBottomConstant: CGFloat = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? 80 : 40

        NSLayoutConstraint.activate([
            self.logoImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
            self.logoImageView.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
            self.logoImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 170),
            self.logoImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: logoBottomConstant),
        ])
    }
}
