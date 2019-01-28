//
//  AuthVC.swift
//  CallTaxiCone
//
//  Created by Akil Kumar Thota on 1/28/19.
//  Copyright © 2019 Akil Kumar Thota. All rights reserved.
//

import UIKit

class AuthVC: UIViewController {
    
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    @IBOutlet weak var emailTextField: RoundedTextField!
    
    @IBOutlet weak var passswordTextField: RoundedTextField!
    
    @IBOutlet weak var switchButton: UISwitch!
    
    @IBOutlet weak var signUpLoginButton: RoundedShadowButton!
    
    @IBOutlet weak var signUpLoginWidthConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var signUpLoginHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureRequestRideButton()
        
    }
    
    func configureRequestRideButton() {
        signUpLoginButton.widthConstraint = signUpLoginWidthConstraint
        signUpLoginButton.heightConstraint = signUpLoginHeightConstraint
    }
    
    @IBAction func switchButtonChanged(_ sender: Any) {
        if switchButton.isOn {
            signUpLoginButton.setTitle("Login", for: .normal)
        } else {
            signUpLoginButton.setTitle("Sign Up", for: .normal)
        }
    }
    
    @IBAction func signUpLoginButtonTapped(_ sender: Any) {
        switchButton.isEnabled = false
        activityIndicator.startAnimating()
        signUpLoginButton.animateButton(shouldLoad: true, message: nil)
    }
    


}
