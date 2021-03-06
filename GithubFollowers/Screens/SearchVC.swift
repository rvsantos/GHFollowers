//
//  SearchVC.swift
//  GithubFollowers
//
//  Created by Rafael V. dos Santos on 12/11/20.
//

import UIKit

class SearchVC: UIViewController {

    // MARK: - Variables
    let logoImageView       = UIImageView()
    let usernameTextField   = GFTextField(placeholder: "Enter a usarname")
    let callToActionButton  = GFButton(backgroundColor: .systemGreen, title: "Get Followers")
    
    var isUsernameEntered: Bool { return !self.usernameTextField.text!.isEmpty }
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        self.configure()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.usernameTextField.text = ""
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    
    // MARK: - Private
    private func configure() {
        view.addSubViews(self.logoImageView, self.usernameTextField, self.callToActionButton)
        self.configureLogoImageView()
        self.configureTextField()
        self.configureCallToActionButton()
        self.createDismissKeyboardTapGesture()
    }
    
    
    private func createDismissKeyboardTapGesture() {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        self.view.addGestureRecognizer(tap)
    }
    
    
    private func configureLogoImageView() {
        self.logoImageView.translatesAutoresizingMaskIntoConstraints = false
        self.logoImageView.image = Images.ghLogo
        
        let topConstraintConstant: CGFloat = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? 20 : 80
        
        NSLayoutConstraint.activate([
            self.logoImageView.topAnchor.constraint(
                equalTo: self.view.safeAreaLayoutGuide.topAnchor,
                constant: topConstraintConstant),
            self.logoImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.logoImageView.heightAnchor.constraint(equalToConstant: 200),
            self.logoImageView.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    
    private func configureTextField() {
        self.usernameTextField.delegate = self
        
        NSLayoutConstraint.activate([
            self.usernameTextField.topAnchor.constraint(equalTo: self.logoImageView.bottomAnchor, constant: 48),
            self.usernameTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 50),
            self.usernameTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -50),
            self.usernameTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    
    private func configureCallToActionButton() {
        self.callToActionButton.addTarget(self, action: #selector(self.pushFollowerListVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            self.callToActionButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            self.callToActionButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 50),
            self.callToActionButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -50),
            self.callToActionButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    
    // MARK: - @objc
    @objc private func pushFollowerListVC() {
        guard self.isUsernameEntered else {
            self.presentGFAlertOnMainThread(title: "Empty Username",
                                            message: "Please enter a username. We need to know who to look for 😄.",
                                            buttonTitle: "Ok")
            return
        }
        
        self.usernameTextField.resignFirstResponder()
        
        guard let username = self.usernameTextField.text else { return }
        let followerListVC = FollowerListVC(username: username)
        self.navigationController?.pushViewController(followerListVC, animated: true)
    }
}


// MARK: - Extension: UITextFieldDelegate
extension SearchVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.pushFollowerListVC()
        return true
    }
}
