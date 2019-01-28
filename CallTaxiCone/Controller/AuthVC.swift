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
    
    @IBOutlet weak var segmentControlHeight: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureRequestRideButton()
        
    }
    
    func configureRequestRideButton() {
        signUpLoginButton.widthConstraint = signUpLoginWidthConstraint
        signUpLoginButton.heightConstraint = signUpLoginHeightConstraint
    }
    
    func displayAlert(title:String?,Body:String?) {
        let alert = UIAlertController(title: title, message: Body, preferredStyle: .alert)
        let action = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func prepareForLoginStart() {
        self.view.endEditing(true)
        signUpLoginButton.isEnabled = false
        switchButton.isEnabled = false
        emailTextField.isEnabled = false
        passswordTextField.isEnabled = false
        segmentControl.isEnabled = false
        activityIndicator.startAnimating()
        signUpLoginButton.animateButton(shouldLoad: true, message: nil)
    }
    
    
    func resetTheUIForLogin() {
        self.view.endEditing(true)
        signUpLoginButton.isEnabled = true
        switchButton.isEnabled = true
        emailTextField.isEnabled = true
        passswordTextField.isEnabled = true
        segmentControl.isEnabled = true
        activityIndicator.stopAnimating()
        signUpLoginButton.animateButton(shouldLoad: false, message: switchButton.isOn ? "Login" : "Sign Up")
    }
    

    
    @IBAction func switchButtonChanged(_ sender: Any) {
        if switchButton.isOn {
            UIView.animate(withDuration: 0.2) {
                self.segmentControlHeight.constant = 0
                self.segmentControl.alpha = 0
                self.view.layoutIfNeeded()
            }
            signUpLoginButton.setTitle("Login", for: .normal)
        } else {
            UIView.animate(withDuration: 0.2) {
                self.segmentControlHeight.constant = 40
                self.segmentControl.alpha = 1
                self.view.layoutIfNeeded()
            }
            signUpLoginButton.setTitle("Sign Up", for: .normal)
        }
    }
    
    
    @IBAction func signUpLoginButtonTapped(_ sender: Any) {
    
        guard let email = emailTextField.text, email != "", let password = passswordTextField.text, password != "" else {
            displayAlert(title: "Empty Fields", Body: "Please fill out all the required fields")
            return
        }
        emailTextField.text = ""
        passswordTextField.text = ""
        prepareForLoginStart()
        if switchButton.isOn {
            // login
            AuthService.sharedInstance.logInUser(email: email, password: password) { (success, err) in
                if !success {
                    self.displayAlert(title: "Error", Body: err)
                    self.resetTheUIForLogin()
                    return
                }
                self.dismiss(animated: true, completion: nil)
            }
            
        } else {
            AuthService.sharedInstance.registerUser(email: email, password: password, isDriver: segmentControl.selectedSegmentIndex == 0 ? false : true) { (success, err) in
                if !success {
                    self.displayAlert(title: "Error", Body: err)
                    self.resetTheUIForLogin()
                    return
                }
                self.dismiss(animated: true, completion: nil)
            }
        }
        
    }
    
    @IBAction func dismissButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

}
