//
//  SidePanelVC.swift
//  CallTaxiCone
//
//  Created by Akil Kumar Thota on 1/28/19.
//  Copyright © 2019 Akil Kumar Thota. All rights reserved.
//

import UIKit

class SidePanelVC: UIViewController {

    
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addShadow()
    }
    
    func addShadow() {
        self.view.layer.shadowOpacity = 0.3
         self.view.layer.shadowRadius = 5.0
         self.view.layer.shadowColor = UIColor.black.cgColor
         self.view.layer.shadowOffset = CGSize(width: 0, height: 5)
    }
   
    @IBAction func loginButtonTapped(_ sender: Any) {
        guard let AuthVC = storyboard?.instantiateViewController(withIdentifier: "AuthVC") else {
            return
        }
        present(AuthVC, animated: true, completion: nil)
    }
    
}
