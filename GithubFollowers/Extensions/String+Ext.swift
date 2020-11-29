//
//  String+Ext.swift
//  GithubFollowers
//
//  Created by Rafael V. dos Santos on 20/11/20.
//

import Foundation

extension String {
    
    func convertToDate() -> Date? {
        let dateFormatter           = DateFormatter()
        dateFormatter.dateFormat    = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.locale        = Locale(identifier: "pt_BR")
        dateFormatter.timeZone      = .current
        return dateFormatter.date(from: self)
    }
    
    
    func convertToDisplayFormat() -> String {
        guard let date = self.convertToDate() else { return "N/A" }
        return date.convertToMonthYearFormat()
    }
}
