//
//  RoundedShadowView.swift
//  CallTaxiCone
//
//  Created by Akil Kumar Thota on 1/27/19.
//  Copyright © 2019 Akil Kumar Thota. All rights reserved.
//

import UIKit

class RoundedShadowView: UIView {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupShadowView()
    }
    
    
    func setupShadowView() {
        self.layer.shadowOpacity = 0.3
        self.layer.shadowRadius = 5.0
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.cornerRadius = 5.0
        self.layer.shadowOffset = CGSize(width: 0, height: 5)
    }

}
