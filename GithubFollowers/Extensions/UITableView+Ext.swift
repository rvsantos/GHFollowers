//
//  UITableView+Ext.swift
//  GithubFollowers
//
//  Created by Rafael V. dos Santos on 27/11/20.
//

import UIKit

extension UITableView {
    
    func reloadDataOnMainThread() {
        DispatchQueue.main.async { self.reloadData() }
    }
    
    
    func removeExcessCell() {
        tableFooterView = UIView(frame: .zero)
    }
}
