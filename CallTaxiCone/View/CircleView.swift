//
//  CircleView.swift
//  CallTaxiCone
//
//  Created by Akil Kumar Thota on 1/27/19.
//  Copyright © 2019 Akil Kumar Thota. All rights reserved.
//

import UIKit

class CircleView: UIView {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupView()
    }
    
    func setupView() {
        self.layer.cornerRadius = self.bounds.width / 2
        self.layer.borderWidth = 1.5
        self.layer.borderColor = UIColor.black.cgColor
    }

}
