//
//  GradientView.swift
//  CallTaxiCone
//
//  Created by Akil Kumar Thota on 1/27/19.
//  Copyright © 2019 Akil Kumar Thota. All rights reserved.
//

import UIKit

class GradientView: UIView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupGradientView()
    }
    
    func setupGradientView() {
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.colors = [UIColor.white.cgColor,UIColor.init(white: 1.0, alpha: 0.0).cgColor]
        gradientLayer.startPoint = CGPoint.zero
        gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        gradientLayer.locations = [0.8,1.0]
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
}
