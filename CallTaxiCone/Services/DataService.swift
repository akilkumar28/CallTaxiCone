//
//  DataService.swift
//  CallTaxiCone
//
//  Created by Akil Kumar Thota on 1/28/19.
//  Copyright © 2019 Akil Kumar Thota. All rights reserved.
//

import UIKit
import Firebase

let DB_BASE = Database.database().reference()

class DataService {
    
    private init() {}
    static let sharedInstance = DataService()
    
    
    let REF_BASE = DB_BASE
    let REF_USERS = DB_BASE.child("users")
    let REF_DRIVERS = DB_BASE.child("drivers")
    let REF_TRIPS = DB_BASE.child("trips")
    
    func createFirebaseDBUser(isDriver:Bool, uid:String, userData:[String:Any]) {
        if isDriver {
            REF_DRIVERS.child(uid).updateChildValues(userData)
        } else {
            REF_USERS.child(uid).updateChildValues(userData)
        }
    }
    
}
