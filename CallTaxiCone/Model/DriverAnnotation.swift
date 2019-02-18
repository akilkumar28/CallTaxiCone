//
//  DriverAnnotation.swift
//  CallTaxiCone
//
//  Created by Akil Kumar Thota on 2/12/19.
//  Copyright © 2019 Akil Kumar Thota. All rights reserved.
//

import UIKit
import MapKit

class DriverAnnotation: NSObject, MKAnnotation {
    
    
    dynamic var coordinate: CLLocationCoordinate2D
    
    var key:String
    
    init(coordinate:CLLocationCoordinate2D,key:String) {
        self.coordinate = coordinate
        self.key = key
    }
    
    func updateDriverAnnotation(cooridnate:CLLocationCoordinate2D) {
        UIView.animate(withDuration: 0.2) {
            self.coordinate = cooridnate
        }
    }
    
    
}
