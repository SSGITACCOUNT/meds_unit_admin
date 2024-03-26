//
//  ContactVM.swift
//  PharmacyAdminApp
//
//  Created by Shashee on 2024-02-28.
//

import Foundation

class ContactVM {
    var orderModel: Order?
    
    let chatModel: [ChatModel] = [
        ChatModel(isSender: true, userName: "Asha", message: "HI"),
        ChatModel(isSender: false, userName: "Sha", message: "HI"),
        ChatModel(isSender: true, userName: "Asha", message: "How are You?"),
        ChatModel(isSender: false, userName: "Sha", message: "Keeping well, you?"),
        ChatModel(isSender: true, userName: "Asha", message: "Fine"),
        ChatModel(isSender: true, userName: "Asha", message: "ok"),
        ChatModel(isSender: false, userName: "Sha", message: "thanks")
    ]
}

struct ChatModel {
    var isSender: Bool?
    var userName: String?
    var message: String?
}

struct MessageFireData: Codable {
    var message: String?
    var pharmacyId: String?
    var sender: Sender?
    var receiver: Receiver?
    var status: String?
    var timestamp: String?
}

struct Sender : Codable {
    var imageUrl: String?
    var name: String?
    var phoneNumber: String?
}

struct Receiver : Codable {
    var imageUrl: String?
    var name: String?
    var phoneNumber: String?
}
