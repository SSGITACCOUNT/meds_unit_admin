//
//  AppDelegate.swift
//  PharmacyAdminApp
//
//  Created by Sashikala Sewwandi on 2024-01-17.
//

import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
import FirebaseAnalytics

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    static var standard: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//        GoogleMapsManager.shared.configure()
        FirebaseApp.configure()
        AppDelegate.standard.window?.rootViewController = ApplicationServiceProvider.shared.viewController(in: .Auth, identifier: "LaunchScreenVC")
        return true
    }
}

