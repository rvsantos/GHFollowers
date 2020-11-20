//
//  UserInfoVC.swift
//  GithubFollowers
//
//  Created by Rafael V. dos Santos on 16/11/20.
//

import UIKit

class UserInfoVC: UIViewController {

    // MARK: - Properties
    private var username: String?
    private let headerView          = UIView()
    private let itemViewOne         = UIView()
    private let itemViewTwo         = UIView()
    private var itemViews: [UIView] = []
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.configureViewController()
        self.layoutUI()
        self.get(user: self.username!)
    }
    
    // MARK: - Helpers
    func set(username: String) {
        self.username = username
    }
    
    private func layoutUI() {
        let padding: CGFloat    = 20
        let itemHeigth: CGFloat = 140
        
        self.itemViews = [self.headerView, self.itemViewOne, self.itemViewTwo]
        
        for itemView in self.itemViews {
            self.view.addSubview(itemView)
            itemView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                itemView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: padding),
                itemView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -padding),
            ])
        }
     
        self.itemViewOne.backgroundColor = .systemBlue
        self.itemViewTwo.backgroundColor = .systemPink
        
        NSLayoutConstraint.activate([
            self.headerView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.headerView.heightAnchor.constraint(equalToConstant: 180),
            
            self.itemViewOne.topAnchor.constraint(equalTo: self.headerView.bottomAnchor, constant: 40),
            self.itemViewOne.heightAnchor.constraint(equalToConstant: itemHeigth),
            
            self.itemViewTwo.topAnchor.constraint(equalTo: self.itemViewOne.bottomAnchor, constant: padding),
            self.itemViewTwo.heightAnchor.constraint(equalToConstant: itemHeigth),
        ])
    }
    
    private func configureViewController() {
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        self.navigationItem.rightBarButtonItem = doneButton
    }
    
    private func add(childVC: UIViewController, to containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
    
    private func get(user: String) {
        NetworkManager.shared.getUserInfo(for: user) { [weak self] (result) in
            guard let self = self else { return }
            
            switch result {
            case .success(let user):
                DispatchQueue.main.async {
                    self.add(childVC: GFUserInfoHeaderVC(user: user), to: self.headerView)
                }
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    // MARK: - @objc
    @objc private func dismissVC() {
        self.dismiss(animated: true, completion: nil)
    }
}
