//
//  LaunchScreenVM.swift
//  PharmacyAdminApp
//
//  Created by Shashee on 2024-01-27.
//

import Foundation
import FirebaseAuth

class LaunchScreenVM{
    
    func checkIsUserAuthenticatedFromFirebase(completion: CompletionHandlerWithData?){
        let currentUser =  Auth.auth().currentUser
        if currentUser != nil {
            Auth.auth().currentUser?.reload(completion: { err in
                if let error = err {
                    completion?(false,error.localizedDescription,nil)
                }else{
                    let updatedCurrentUser =  Auth.auth().currentUser
                    if updatedCurrentUser == nil {
                        completion?(false,nil,nil)
                    }else {
                        completion?(true,nil,updatedCurrentUser)
                    }
                }
            })
        }else{
            completion?(false,nil,nil)
        }
        
    }
}


