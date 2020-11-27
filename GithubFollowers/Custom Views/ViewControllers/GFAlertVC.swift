//
//  GFAlertVC.swift
//  GithubFollowers
//
//  Created by Rafael V. dos Santos on 14/11/20.
//

import UIKit

class GFAlertVC: UIViewController {
    
    // MARK: - Components
    private let containerView       = GFAlertContainerView()
    private let titleLabel          = GFTitleLabel(textAlignment: .center, fontSize: 20)
    private let messageLabel        = GFBodyLabel(textAlignment: .center)
    private let actionButton        = GFButton(backgroundColor: .systemPink, title: "Ok")
    
    // MARK: - Constants
    private let padding: CGFloat    = 20
    
    // MARK: - Variables
    private var alertTitle: String?
    private var message: String?
    private var buttonTitle: String?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.75)
        
        view.addSubview(self.containerView)
        self.containerView.addSubViews(self.titleLabel, self.actionButton, self.messageLabel)
        self.configureContainerView()
        self.configureTitleLabel()
        self.configureActionButton()
        self.configureMessageLabel()
    }
    
    // MARK: - Initialization
    init(title: String, message: String, buttonTitle: String) {
        super.init(nibName: nil, bundle: nil)
        self.alertTitle     = title
        self.message        = message
        self.buttonTitle    = buttonTitle
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private
    private func configureContainerView() {
        NSLayoutConstraint.activate([
            self.containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            self.containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            self.containerView.widthAnchor.constraint(equalToConstant: 280),
            self.containerView.heightAnchor.constraint(equalToConstant: 220)
        ])
    }
        
    private func configureTitleLabel() {
        self.titleLabel.text = self.alertTitle ?? "Something went wrong"
        
        NSLayoutConstraint.activate([
            self.titleLabel.topAnchor.constraint(equalTo: self.containerView.topAnchor, constant: self.padding),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: self.padding),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: -self.padding),
            self.titleLabel.heightAnchor.constraint(equalToConstant: 28)
        ])
    }
    
    private func configureActionButton() {
        self.actionButton.setTitle(self.buttonTitle ?? "Ok", for: .normal)
        self.actionButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            self.actionButton.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor, constant: -padding),
            self.actionButton.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: padding),
            self.actionButton.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: -padding),
            self.actionButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }

    private func configureMessageLabel() {
        self.messageLabel.text          = self.message ?? "Unable to complete request"
        self.messageLabel.numberOfLines = 4
        
        NSLayoutConstraint.activate([
            self.messageLabel.topAnchor.constraint(equalTo: self.titleLabel.topAnchor, constant: 8),
            self.messageLabel.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: padding),
            self.messageLabel.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: -padding),
            self.messageLabel.bottomAnchor.constraint(equalTo: self.actionButton.bottomAnchor, constant: -12),
        ])
    }
    
    // MARK: - @objc
    @objc private func dismissVC() {
        self.dismiss(animated: true, completion: nil)
    }
    
}
