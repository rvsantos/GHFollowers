//
//  GFItemInfoVC.swift
//  GithubFollowers
//
//  Created by Rafael V. dos Santos on 19/11/20.
//

import UIKit

class GFItemInfoVC: UIViewController {

    // MARK: - Properties
    let stackView       = UIStackView()
    let itemInfoViewOne = GFItemInfoView()
    let itemInfoViewTwo = GFItemInfoView()
    let actionButton    = GFButton()
    
    var user: User!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureBackgroundView()
        self.layoutUI()
        self.configureStackView()
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
    private func configureBackgroundView() {
        view.layer.cornerRadius = 18
        view.backgroundColor    = .secondarySystemBackground
    }
    
    private func configureStackView() {
        self.stackView.axis         = .horizontal
        self.stackView.distribution = .equalSpacing
        
        self.stackView.addArrangedSubview(self.itemInfoViewOne)
        self.stackView.addArrangedSubview(self.itemInfoViewTwo)
    }
    
    private func layoutUI() {
        view.addSubview(self.stackView)
        view.addSubview(self.actionButton)
        
        self.stackView.translatesAutoresizingMaskIntoConstraints = false
        
        let padding: CGFloat = 20
        
        NSLayoutConstraint.activate([
            self.stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            self.stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            self.stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            self.stackView.heightAnchor.constraint(equalToConstant: 50),
            
            self.actionButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding),
            self.actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            self.actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            self.actionButton.heightAnchor.constraint(equalToConstant: 44),
        ])
    }

}
