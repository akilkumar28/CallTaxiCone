//
//  AuthService.swift
//  CallTaxiCone
//
//  Created by Akil Kumar Thota on 1/28/19.
//  Copyright © 2019 Akil Kumar Thota. All rights reserved.
//

import UIKit
import Firebase


class AuthService {
    
    private init() {}
    static let sharedInstance = AuthService()
    
    
    func registerUser(email:String,password:String,isDriver:Bool,completion:@escaping (_ success:Bool,_ err:String?) -> ()) {
        
        Auth.auth().createUser(withEmail: email, password: password) { (AuthData, error) in
            if error != nil {
                completion(false,error?.localizedDescription)
                return
            }
            guard let user = AuthData?.user else {
                return
            }
            var userData:[String:Any]?
            if isDriver {
                userData = ["provider":user.providerID,
                "userIsDriver":true,
                "isPickingModeEnabled":false,
                "driverOnTrip":false,
                ]
            } else {
                userData = ["provider":user.providerID,
                            "userIsDriver":false,]
            }
            DataService.sharedInstance.createFirebaseDBUser(isDriver: isDriver, uid: user.uid, userData: userData!)
            completion(true,nil)
        }
        
    }
    
    
    func logInUser(email:String,password:String,completion:@escaping (_ success:Bool,_ err:String?) -> ()) {
        Auth.auth().signIn(withEmail: email, password: password) { (AuthData, error) in
            if error != nil {
                completion(false,error?.localizedDescription)
                return
            }
            completion(true,nil)
        }
    }
}
