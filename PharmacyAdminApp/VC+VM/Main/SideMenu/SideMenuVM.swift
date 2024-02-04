//
//  SideMenuVM.swift
//  PharmacyAdminApp
//
//  Created by Sashikala Sewwandi on 2024-01-18.
//

import UIKit

class SideMenuVM {
    
    var menuList: [SideMenuModel] = [
        SideMenuModel(image: UIImage(named: "home-page"), name: "Home", targetIdentifier: "Home.Menu"),
        SideMenuModel(image: UIImage(named: "shopping-cart"), name: "Orders", targetIdentifier: "Order.Menu"),
        SideMenuModel(image: UIImage(named: "call"), name: "Contact", targetIdentifier: "Contact.Menu"),
    ]
}

struct SideMenuModel {
    var image: UIImage?
    var name: String?
    var targetIdentifier: String
}
