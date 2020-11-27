//
//  UIView+Ext.swift
//  GithubFollowers
//
//  Created by Rafael V. dos Santos on 26/11/20.
//

import UIKit

extension UIView {
    func addSubViews(_ views: UIView...) {
        for view in views { addSubview(view) }
    }
}
