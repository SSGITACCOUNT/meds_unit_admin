//
//  Constants.swift
//  PharmacyAdminApp
//
//  Created by Shashee on 2024-01-27.
//

import Foundation
import FirebaseAuth
import CoreLocation

class Constants {
    static let shared: Constants = {
        let _shared = Constants()
        return _shared
    }()
    
    let GOOGLEMAPS_APP_BASE_URL = "comgooglemaps://"
    let DIRECTION_API_BASE_URL = "https://maps.googleapis.com/maps/api/directions/json"
    let MAPKEY = "AIzaSyCFMq2b79YXWsOmacpZq705rlu8lfpLjYw"
    let MAPID = "ec7c328f965b4bbb"
    
    
    var userId: String?
    var isAdmin: Bool?
    var selectedUserAddress: String?
    var selectedUserAddressLocation: CLLocation?
    var currentLoggedInFireStoreUser : FirestoreUser?
    var currentLoggedInFirebaseAuthUser : User?
}
