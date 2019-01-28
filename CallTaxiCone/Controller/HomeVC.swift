//
//  HomeVC.swift
//  CallTaxiCone
//
//  Created by Akil Kumar Thota on 1/27/19.
//  Copyright © 2019 Akil Kumar Thota. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {
    
    @IBOutlet weak var requestRideButton: RoundedShadowButton!
    @IBOutlet weak var requestRideButtonActivitySpinner: UIActivityIndicatorView!
    @IBOutlet weak var requestRideButtonHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var requestRideButtonWidthConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var sidePanelLeadingConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var whiteCoverView: UIView!
    
    
    var sidePanelIsOpen = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureRequestRideButton()
        addTouchToWhitePanel()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func addTouchToWhitePanel() {
        let touch = UITapGestureRecognizer()
        touch.numberOfTapsRequired = 1
        touch.addTarget(self, action: #selector(whiteViewTapped))
        whiteCoverView.addGestureRecognizer(touch)
    }
    
    @objc func whiteViewTapped() {
        sidePanelIsOpen = false
        dismissSideView()
    }
    
    
    func bringOutSideView() {
        whiteCoverView.isHidden = false
        self.whiteCoverView.alpha = 0.6
        UIView.animate(withDuration: 0.4) { self.sidePanelLeadingConstraint.constant = 0
            self.view.layoutIfNeeded()
        }
    }
    
    
    func dismissSideView() {
        whiteCoverView.isHidden = true
        self.whiteCoverView.alpha = 1
        UIView.animate(withDuration: 0.4) {
            self.sidePanelLeadingConstraint.constant = -500
            self.view.layoutIfNeeded()
        }
    }
    
    
    
    
    func configureRequestRideButton() {
        requestRideButton.widthConstraint = requestRideButtonWidthConstraint
        requestRideButton.heightConstraint = requestRideButtonHeightConstraint
    }
    
    @IBAction func requestRideButtonTapped(_ sender: Any) {
        requestRideButtonActivitySpinner.startAnimating()
        requestRideButton.animateButton(shouldLoad: true, message: nil)
    }
    
    @IBAction func menuButtonTapped(_ sender: Any) {
        if sidePanelIsOpen {
            dismissSideView()
        } else {
            bringOutSideView()
        }
        sidePanelIsOpen = !sidePanelIsOpen
    }
}

