//
//  FirestorePharmacyStore.swift
//  PharmacyAdminApp
//
//  Created by Shashee on 2024-02-01.
//

import Foundation
import FirebaseFirestore

struct FirestorePharmacyStore: Codable {
    var id:String
    var address: String
    var storeName: String
    var storeLogo : String
    let location:GeoPoint
}

