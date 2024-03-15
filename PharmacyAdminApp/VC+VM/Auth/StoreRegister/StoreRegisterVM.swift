//
//  StoreRegisterVM.swift
//  PharmacyAdminApp
//
//  Created by Shashee on 2024-03-16.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class StoreRegisterVM {
    
    func validateStoreRegisterForm(storeName:String?,address:String?,phoneNumber:String?,location:GeoPoint?,completion:ActionHandler){
        do {
            if try validateForm(storeName: storeName, address: address, phoneNumber:phoneNumber, location:location) {
                completion(true, NSLocalizedString("SUCCESS", comment: "Success"))
            }
        } catch ValidateError.invalidData(let message) {
            completion(false, message)
        } catch {
            completion(false, NSLocalizedString("MISSING_DATA", comment: "Missing Data"))
        }
    }
    
    private func validateForm(storeName:String?,address:String?,phoneNumber:String?,location:GeoPoint?) throws -> Bool {
        guard let _storeName = storeName else {
            throw ValidateError.invalidData("Enter Store Name")
        }
        guard !(_storeName.trimLeadingTralingNewlineWhiteSpaces().isEmpty) else {
            throw ValidateError.invalidData("Enter Store Name")
        }
        guard let _address = address else {
            throw ValidateError.invalidData("Enter Store Address")
        }
        guard !(_address.trimLeadingTralingNewlineWhiteSpaces().isEmpty) else {
            throw ValidateError.invalidData("Enter Store Address")
        }
        
        guard let _phoneNumber = phoneNumber else {
            throw ValidateError.invalidData("Enter Phone Number")
        }
        guard !(_phoneNumber.trimLeadingTralingNewlineWhiteSpaces().isEmpty) else {
            throw ValidateError.invalidData("Enter Phone Number")
        }
        guard (_phoneNumber.isValidSLPhoneNumber()) else {
            throw ValidateError.invalidData("Enter Phone Number")
        }
        guard let _location = location else {
            throw ValidateError.invalidData("Enter Location")
        }
        return true
    }
    
    func createNewStoreOnFirebase(storeName:String?,address:String?,phoneNumber:String?,location:GeoPoint?,completionWithPayload:CompletionHandlerWithData?){
        validateStoreRegisterForm(storeName: storeName, address: address, phoneNumber: phoneNumber, location: location) { status, message in
            let currentUser =  Auth.auth().currentUser
            if let _userId = currentUser?.uid , let _location = location {
                let firestoreUser = FirestorePharmacyStore(id: _userId, address: address ?? "", storeName: storeName ?? "",storeLogo: DefaultPlaceHolderLinks.store_logo.rawValue, location: _location)
                FirestoreUserManager.shared.storeDetailsOnFirestoreDb(firestoreUser:firestoreUser, completionWithPayload: completionWithPayload)
            }
        }
    }
}


