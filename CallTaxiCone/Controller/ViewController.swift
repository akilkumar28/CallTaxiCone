//
//  ViewController.swift
//  CallTaxiCone
//
//  Created by Akil Kumar Thota on 1/27/19.
//  Copyright © 2019 Akil Kumar Thota. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var requestRideButton: RoundedShadowButton!
    @IBOutlet weak var requestRideButtonActivitySpinner: UIActivityIndicatorView!
    
    @IBOutlet weak var requestRideButtonHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var requestRideButtonWidthConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureRequestRideButton()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func configureRequestRideButton() {
        requestRideButton.widthConstraint = requestRideButtonWidthConstraint
        requestRideButton.heightConstraint = requestRideButtonHeightConstraint
    }

    @IBAction func requestRideButtonTapped(_ sender: Any) {
        requestRideButtonActivitySpinner.startAnimating()
        requestRideButton.animateButton(shouldLoad: true, message: nil)
    }
    
}

