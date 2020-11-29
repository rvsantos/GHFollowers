//
//  Date+Ext.swift
//  GithubFollowers
//
//  Created by Rafael V. dos Santos on 20/11/20.
//

import Foundation

extension Date {
    
    func convertToMonthYearFormat() -> String {
        let dateFormatter           = DateFormatter()
        dateFormatter.dateFormat    = "MMM yyyy"
        return dateFormatter.string(from: self)
    }
}
