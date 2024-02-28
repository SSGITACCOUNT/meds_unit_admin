//
//  SignUpVM.swift
//  PharmacyAdminApp
//
//  Created by Shashee on 2024-02-27.
//

import Foundation
import FirebaseAuth

class SignUpVM {
    
    
    func validateSignUpForm(fName:String?,email:String?,phoneNumber:String?,password:String?,confirmPassword:String?,completion:ActionHandler){
        do {
            if try validateForm(fName: fName, email: email, phoneNumber:phoneNumber, password:password, confirmPassword: confirmPassword) {
                completion(true, NSLocalizedString("SUCCESS", comment: "Success"))
            }
        } catch ValidateError.invalidData(let message) {
            completion(false, message)
        } catch {
            completion(false, NSLocalizedString("MISSING_DATA", comment: "Missing Data"))
        }
    }
    
    private func validateForm(fName:String?,email:String?,phoneNumber:String?,password:String?,confirmPassword:String?) throws -> Bool {
        guard let _fName = fName else {
            throw ValidateError.invalidData(NSLocalizedString("VALID_FULL_NAME_REQUIRED", comment: "Enter Valid Full Name"))
        }
        guard !(_fName.trimLeadingTralingNewlineWhiteSpaces().isEmpty) else {
            throw ValidateError.invalidData(NSLocalizedString("VALID_FULL_NAME_REQUIRED", comment: "Enter Valid Full Name"))
        }
        guard let _email = email else {
            throw ValidateError.invalidData(NSLocalizedString("VALID_EMAIL_REQUIRED", comment: "Enter Valid Email"))
        }
        guard !(_email.trimLeadingTralingNewlineWhiteSpaces().isEmpty) else {
            throw ValidateError.invalidData(NSLocalizedString("VALID_EMAIL_REQUIRED", comment: "Enter Valid Email"))
        }
        guard (_email.isValidEmailAddress()) else {
            throw ValidateError.invalidData(NSLocalizedString("VALID_EMAIL_REQUIRED", comment: "Enter Valid Email"))
        }
        guard let _phoneNumber = phoneNumber else {
            throw ValidateError.invalidData(NSLocalizedString("VALID_PHONE_NUMBER_REQUIRED", comment: "Enter Valid Phone Number"))
        }
        guard !(_phoneNumber.trimLeadingTralingNewlineWhiteSpaces().isEmpty) else {
            throw ValidateError.invalidData(NSLocalizedString("VALID_PHONE_NUMBER_REQUIRED", comment: "Enter Valid Phone Number"))
        }
        guard (_phoneNumber.isValidSLPhoneNumber()) else {
            throw ValidateError.invalidData(NSLocalizedString("VALID_SL_PHONE_NUMBER_REQUIRED", comment: "Enter Valid SL Phone Number"))
        }
        guard let _password = password else {
            throw ValidateError.invalidData(NSLocalizedString("ENTER_PASSWORD", comment: "Enter Password"))
        }
        guard !(_password.isEmpty) else {
            throw ValidateError.invalidData(NSLocalizedString("ENTER_PASSWORD", comment: "Enter Password"))
        }
        guard let _confirmPassword = confirmPassword else {
            throw ValidateError.invalidData(NSLocalizedString("ENTER_CONFIRM_PASSWORD", comment: "Enter Confirm Password"))
        }
        guard !(_confirmPassword.isEmpty) else {
            throw ValidateError.invalidData(NSLocalizedString("ENTER_CONFIRM_PASSWORD", comment: "Enter Confirm Password"))
        }
        
        guard (_confirmPassword == _password) else {
            throw ValidateError.invalidData(NSLocalizedString("PASSWORDS_DOESNT_MATCH", comment: "Passwords Doesnt Match"))
        }
        
        return true
    }
    
    func createNewUserOnFirebase(fullName:String?, email:String?, phoneNumber:String?, password:String?, confirmPassword:String?, completionWithPayload:CompletionHandlerWithData?){
        self.validateSignUpForm(fName: fullName, email: email, phoneNumber: phoneNumber, password: password, confirmPassword: confirmPassword) { status, message in
            return
        }
//        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
//            guard let user = authResult?.user, error == nil else {
//                completionWithPayload?(false,error?.localizedDescription,nil)
//                return
//            }
//            Constants.shared.currentLoggedInFirebaseAuthUser = user
//            Constants.shared.userId = user.uid
//            let firestoreUser = FirestoreUser(id: user.uid, fName: fName, phone: phoneNumber, avatarUrl: DefaultPlaceHolderLinks.user_avatar.rawValue)
//            FirestoreUserManager.shared.storeSignedUpUserDetailsOnFirestoreDb(firebaseUser: user,firestoreUser:firestoreUser, completionWithPayload: completionWithPayload)
//        }
    }
}
