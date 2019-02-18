//
//  HomeVC.swift
//  CallTaxiCone
//
//  Created by Akil Kumar Thota on 1/27/19.
//  Copyright © 2019 Akil Kumar Thota. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import RevealingSplashView
import Firebase


class HomeVC: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var requestRideButton: RoundedShadowButton!
    @IBOutlet weak var requestRideButtonActivitySpinner: UIActivityIndicatorView!
    @IBOutlet weak var requestRideButtonHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var requestRideButtonWidthConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var sidePanelLeadingConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var whiteCoverView: UIView!
    
    
    var locationManager:CLLocationManager!
    
    var sidePanelIsOpen = false
    
    var splashView : RevealingSplashView!
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        locationSetup()
        mapView.delegate = self
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        centerMapOnUserLocation()

        
        
        configureRequestRideButton()
        addTouchToWhitePanel()
        configureSplashView()
        
        
        loadDriverAnnotationOnMapView()
        
        
        
    }
    
    
    fileprivate func locationSetup() {
        
        
        
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        locationManager.distanceFilter = kCLDistanceFilterNone
        let status = CLLocationManager.authorizationStatus()
        if status == .notDetermined || status == .denied || status == .authorizedWhenInUse {
            
            locationManager.requestAlwaysAuthorization()
            locationManager.requestWhenInUseAuthorization()
        }
        locationManager.startUpdatingLocation()
        

    }
    
    func loadDriverAnnotationOnMapView() {
        DataService.sharedInstance.REF_DRIVERS.observe(.value) { (snapshot) in
            if let driverSnapshot = snapshot.children.allObjects as? [DataSnapshot] {
                for driver in driverSnapshot {
                    if driver.hasChild("coordinate") {
                        if driver.childSnapshot(forPath: "isPickingModeEnabled").value as? Bool == true {
                            if let value = driver.value as? [String:Any] {
                                if let coordArray = value["coordinate"] as? NSArray {
                                    let driverCoordinate = CLLocationCoordinate2D(latitude: coordArray[0] as! CLLocationDegrees, longitude: coordArray[1] as! CLLocationDegrees)
                                    let annotaion = DriverAnnotation(coordinate: driverCoordinate, key: driver.key)
                                    let isPresent = self.mapView.annotations.contains(where: { (annotation) -> Bool in
                                        if let driverAnnotation = annotation as? DriverAnnotation {
                                            if driverAnnotation.key == driver.key {
                                                driverAnnotation.updateDriverAnnotation(cooridnate: driverCoordinate)
                                                return true
                                            }
                                        }
                                        return false
                                    })
                                    if !isPresent {
                                        self.mapView.addAnnotation(annotaion)
                                    }
                                }
                            }
                        } else {
                            self.mapView.annotations.contains(where: { (annotation) -> Bool in
                                if let driverAnnotation = annotation as? DriverAnnotation {
                                    if driverAnnotation.key == driver.key {
                                        self.mapView.removeAnnotation(driverAnnotation)
                                        return true
                                    }
                                }
                                return false
                            })
                        }
                    }
                }
            }
        }
    }
    
    func centerMapOnUserLocation() {
        mapView.setRegion(MKCoordinateRegion(center: mapView.userLocation.coordinate, latitudinalMeters: 2000.0, longitudinalMeters: 2000.0), animated: true)
    }
    
    fileprivate func configureSplashView() {
        splashView = RevealingSplashView(iconImage: #imageLiteral(resourceName: "launchScreenIcon"), iconInitialSize: CGSize(width: 80, height: 80), backgroundColor: .white)
        splashView.animationType = .popAndZoomOut
        self.view.addSubview(splashView)
        splashView.startAnimation()
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
    @IBAction func centerLocationButtonTapped(_ sender: Any) {
        centerMapOnUserLocation()
    }
}


extension HomeVC:CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
    }
}


extension HomeVC:MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        
        DataService.sharedInstance.returnUserIsDriverOrNot { (isDriver, isPickingEnabled, err) in
            if err != nil {
                print(err)
                return
            }
            if isDriver {
                UpdateService.sharedInstance.updateDriverLocation(withCoordinate: userLocation.coordinate, isPickingEnabled: isPickingEnabled)
            } else{
                UpdateService.sharedInstance.updateUserLocation(withCoordinate: userLocation.coordinate)
            }
        }
        
    }
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if let annotation = annotation as? DriverAnnotation {
            let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "driver")
            annotationView.image = #imageLiteral(resourceName: "driverAnnotation")
            return annotationView
        }
        return nil
    }
}

