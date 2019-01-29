//
//  SidePanelVC.swift
//  CallTaxiCone
//
//  Created by Akil Kumar Thota on 1/28/19.
//  Copyright © 2019 Akil Kumar Thota. All rights reserved.
//

import UIKit
import Firebase

class SidePanelVC: UIViewController {

    @IBOutlet weak var pickModeEnabledSwitch: UISwitch!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var pickModeEnabledStackView: UIStackView!
    
    @IBOutlet weak var roundedImageView: RounedImageView!
    
    @IBOutlet weak var userEmailLabel: UILabel!
    
    @IBOutlet weak var typeOfUserLabel: UILabel!
    
    @IBOutlet weak var userInfoStackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickModeEnabledSwitch.isOn = false
        addShadow()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configureUserInfoStackView()
    }
    
    func configureUserInfoStackView() {
        if Auth.auth().currentUser == nil {
            userInfoStackView.alpha = 0
            loginButton.setTitle("SignUp / Login", for: .normal)
        } else {
            userInfoStackView.alpha = 1
            loginButton.setTitle("Logout", for: .normal)
            userEmailLabel.text = (Auth.auth().currentUser?.email)!
            
            DataService.sharedInstance.returnUserIsDriverOrNot { (isDriver,isPickingEnabled,err)   in
                if err != nil {
                    print(err)
                    return
                }
                if !isDriver {
                    self.pickModeEnabledStackView.alpha = 0
                    self.typeOfUserLabel.text = "PASSENGER"
                } else {
                    self.pickModeEnabledStackView.alpha = 1
                    self.typeOfUserLabel.text = "DRIVER"
                    self.pickModeEnabledSwitch.isOn = isPickingEnabled
                }
            }
            
        }
    }
    
    func addShadow() {
        self.view.layer.shadowOpacity = 0.3
         self.view.layer.shadowRadius = 5.0
         self.view.layer.shadowColor = UIColor.black.cgColor
         self.view.layer.shadowOffset = CGSize(width: 0, height: 5)
    }
    
    func displayAlert(title:String?,Body:String?) {
        let alert = UIAlertController(title: title, message: Body, preferredStyle: .alert)
        let action = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
   
    @IBAction func loginButtonTapped(_ sender: Any) {
        if Auth.auth().currentUser == nil {
            guard let AuthVC = storyboard?.instantiateViewController(withIdentifier: "AuthVC") else {
                return
            }
            present(AuthVC, animated: true, completion: nil)
        } else {
            do {
                try Auth.auth().signOut()
                userInfoStackView.alpha = 0
                loginButton.setTitle("SignUp / Login", for: .normal)
            } catch {
                self.displayAlert(title: "Error", Body: error.localizedDescription)
            }
        }
    }
    
    
    @IBAction func pickUpModeEnabledSwtichChanged(_ sender: Any) {
        DataService.sharedInstance.REF_DRIVERS.child((Auth.auth().currentUser?.uid)!).updateChildValues(["isPickingModeEnabled":pickModeEnabledSwitch.isOn])
    }
    
    
}
