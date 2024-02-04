//
//  KeychainManager.swift
//  PharmacyAdminApp
//
//  Created by Shashee on 2024-01-26.
//

import Foundation

import UIKit
import KeychainAccess

class KeychainManager {
    fileprivate static let keychain = Keychain(service: "com.tmdone.driver").synchronizable(true).accessibility(.whenUnlockedThisDeviceOnly)
    
    static func set(_ value: String, forKey: KeyManagerEnum) {
        keychain[forKey.rawValue] = value
    }
    
    static func get(forKey: KeyManagerEnum) -> String {
        guard isKeyExist(forKey) else { return "" }
        return keychain[forKey.rawValue] ?? ""
    }
    
    static func delete(forKey: KeyManagerEnum) {
        keychain[forKey.rawValue] = nil
    }
    
    static func isKeyExist(_ findKey: KeyManagerEnum) -> Bool{
        let keys = keychain.allKeys()
        for key in keys{
            if key == findKey.rawValue {
                return true
            }
        }
        return false
    }
}
class UserDefaultManager {
    static func set(_ value: Any, forKey: KeyManagerEnum) {
        UserDefaults.standard.setValue(value, forKey: forKey.rawValue)
    }
    
    static func getString(forKey: KeyManagerEnum) -> String {
        return UserDefaults.standard.string(forKey: forKey.rawValue) ?? ""
    }
    
    static func getBool(forKey: KeyManagerEnum) -> Bool {
        return UserDefaults.standard.bool(forKey: forKey.rawValue)
    }
    
    static func getDouble(forKey: KeyManagerEnum) -> Double {
        return UserDefaults.standard.double(forKey: forKey.rawValue)
    }
    
    static func getData(forKey: KeyManagerEnum) -> Data? {
        return UserDefaults.standard.data(forKey: forKey.rawValue)
    }
    
    static func getObject(forKey: KeyManagerEnum) -> Any? {
        return UserDefaults.standard.object(forKey: forKey.rawValue)
    }
    
    static func delete(forKey: KeyManagerEnum) {
        UserDefaults.standard.removeObject(forKey: forKey.rawValue)
    }
    
    static func deleteAll() {
        guard let domain = Bundle.main.bundleIdentifier else { return }
        UserDefaults.standard.removePersistentDomain(forName: domain)
        UserDefaults.standard.synchronize()
    }
}
