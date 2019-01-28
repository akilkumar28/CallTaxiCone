//
//  RoundedShadowButton.swift
//  CallTaxiCone
//
//  Created by Akil Kumar Thota on 1/27/19.
//  Copyright © 2019 Akil Kumar Thota. All rights reserved.
//

import UIKit

class RoundedShadowButton: UIButton {
    
    
    weak var heightConstraint:NSLayoutConstraint?
    weak var widthConstraint:NSLayoutConstraint?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    func setupView() {
        self.layer.cornerRadius = 5.0
        self.layer.shadowOpacity = 0.3
        self.layer.shadowRadius = 10.0
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize.zero
    }
    
    func animateButton(shouldLoad:Bool,message:String?) {
        if shouldLoad {
            self.setTitle("", for: .normal)
            UIView.animate(withDuration: 0.2) {
                self.layer.cornerRadius = 70 / 2
                self.heightConstraint?.constant = 70
                self.widthConstraint?.constant = 70
                self.layoutIfNeeded()
            }
        } else {
            self.setTitle(message, for: .normal)
            UIView.animate(withDuration: 0.2) {
                self.layer.cornerRadius = 0
                self.heightConstraint?.constant = 65
                self.widthConstraint?.constant = 374
                self.layoutIfNeeded()
        }
    }
}
}
