//
//  GFTitleLabel.swift
//  GithubFollowers
//
//  Created by Rafael V. dos Santos on 14/11/20.
//

import UIKit

class GFTitleLabel: UILabel {

    //MARK:- Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    convenience init(textAlignment: NSTextAlignment, fontSize: CGFloat) {
        self.init(frame: .zero)
        self.textAlignment = textAlignment
        self.font = UIFont.systemFont(ofSize: fontSize, weight: .bold)
    }
    
    
    //MARK:- Private
    private func configure() {
        textColor                   = .label
        adjustsFontSizeToFitWidth   = true
        minimumScaleFactor          = 0.9
        lineBreakMode               = .byTruncatingTail
        translatesAutoresizingMaskIntoConstraints = false
    }
}
