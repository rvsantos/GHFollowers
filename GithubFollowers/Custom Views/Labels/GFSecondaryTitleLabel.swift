//
//  GFSecondaryTitleLabel.swift
//  GithubFollowers
//
//  Created by Rafael V. dos Santos on 17/11/20.
//

import UIKit

class GFSecondaryTitleLabel: UILabel {

    //MARK:- Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(fontSize: CGFloat) {
        super.init(frame: .zero)
        font = UIFont.systemFont(ofSize: fontSize, weight: .medium)
        self.configure()
    }
    
    //MARK:- Private
    private func configure() {
        textColor                   = .secondaryLabel
        adjustsFontSizeToFitWidth   = true
        minimumScaleFactor          = 0.90
        lineBreakMode               = .byTruncatingTail
        translatesAutoresizingMaskIntoConstraints = false
    }

}
