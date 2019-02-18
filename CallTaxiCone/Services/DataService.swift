//
//  DataService.swift
//  CallTaxiCone
//
//  Created by Akil Kumar Thota on 1/28/19.
//  Copyright © 2019 Akil Kumar Thota. All rights reserved.
//

import UIKit
import Firebase
import SwiftyJSON

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
    
    func returnUserIsDriverOrNot(completion:@escaping (_ isDriver:Bool,_ isPickingModeEnabled:Bool,_ err:String?)->()) {
        if Auth.auth().currentUser == nil {
            completion(false,false,"no user present")
            return
        }
        REF_DRIVERS.observeSingleEvent(of: .value) { (snapshot) in
            if let snapshots = snapshot.children.allObjects as? [DataSnapshot] {
                for child in snapshots {
                    if child.key == Auth.auth().currentUser?.uid {
                        if let value = child.value as? [String:Any] {
                            if let isPickingEnabled = value["isPickingModeEnabled"] as? Bool {
                                completion(true,isPickingEnabled,nil)
                                return
                            }
                        }
                    }
                }
                completion(false,false,nil)
                return
            } else {
                completion(false,false,"Couldnt fetch value")
            }
        }
    }

}
