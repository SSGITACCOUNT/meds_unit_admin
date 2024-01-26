//
//  Enum.swift
//  PharmacyAdminApp
//
//  Created by Sashikala Sewwandi on 2024-01-19.
//

import UIKit

enum AppStoryboard: String {
    
    case Auth = "Auth"
    case Home = "Home"
    case Order = "Order"
    case Contact = "Contact"
    
    var instance : UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: nil)
    }
}
