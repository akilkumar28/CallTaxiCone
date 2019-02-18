//
//  UpdateService.swift
//  CallTaxiCone
//
//  Created by Akil Kumar Thota on 2/6/19.
//  Copyright © 2019 Akil Kumar Thota. All rights reserved.
//

import UIKit
import Firebase
import MapKit

class UpdateService {
    
    private init() {}
    static let sharedInstance = UpdateService()
    
    func updateUserLocation(withCoordinate coordinate:CLLocationCoordinate2D) {
        guard let _ = Auth.auth().currentUser else {return}
        DataService.sharedInstance.REF_USERS.child((Auth.auth().currentUser?.uid)!).updateChildValues(["coordinate":[coordinate.latitude,coordinate.longitude]])

    }
    
    
    
    func updateDriverLocation(withCoordinate coordinate:CLLocationCoordinate2D,isPickingEnabled:Bool) {
        if isPickingEnabled {
            guard let _ = Auth.auth().currentUser else {return}
            DataService.sharedInstance.REF_DRIVERS.child((Auth.auth().currentUser?.uid)!).updateChildValues(["coordinate":[coordinate.latitude,coordinate.longitude]])
        }
    }
    
    
    
}
