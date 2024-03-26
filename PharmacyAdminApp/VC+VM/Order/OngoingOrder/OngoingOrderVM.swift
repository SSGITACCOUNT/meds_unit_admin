//
//  OngoingOrderVM.swift
//  PharmacyAdminApp
//
//  Created by Shashee on 2024-03-22.
//

import Foundation
import FirebaseFirestore

struct Order: Codable {
    var customerId: String?
    var imageUrl: String?
    var orderId: String?
    var pharmacyId: String?
    var name: String?
    var phoneNumber: String?
    var orderStatus: String?
    var orderDate: String?
    var user: pharmasist?
}

struct FirestoreOrderWithStore: Codable {
    var firestoreOrder:Order?
    var firestoreStore : FirestorePharmacyStore?
}

struct pharmasist: Codable {
    var avatarUrl: String?
    var fName: String
    var id: String?
    var phone: String?
}
