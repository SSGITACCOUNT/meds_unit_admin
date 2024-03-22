//
//  LoginVM.swift
//  PharmacyAdminApp
//
//  Created by Shashee on 2024-03-21.
//

import Foundation
import FirebaseAuth

public class LoginVM{
    func validateSignInForm(email:String?,password:String?,completion:ActionHandler){
        do {
            if try validateForm(email:email, password:password) {
                completion(true, NSLocalizedString("SUCCESS", comment: "Success"))
            }
        } catch ValidateError.invalidData(let message) {
            completion(false, message)
        } catch {
            completion(false, NSLocalizedString("MISSING_DATA", comment: "Missing Data"))
        }
    }
    
    private func validateForm(email:String?,password:String?) throws -> Bool {
        
        guard let _email = email else {
            throw ValidateError.invalidData(NSLocalizedString("VALID_EMAIL_REQUIRED", comment: "Enter Valid Email"))
        }
        guard !(_email.trimLeadingTralingNewlineWhiteSpaces().isEmpty) else {
            throw ValidateError.invalidData(NSLocalizedString("VALID_EMAIL_REQUIRED", comment: "Enter Valid Email"))
        }
        guard (_email.isValidEmailAddress()) else {
            throw ValidateError.invalidData(NSLocalizedString("VALID_EMAIL_REQUIRED", comment: "Enter Valid Email"))
        }
        guard let _password = password else {
            throw ValidateError.invalidData(NSLocalizedString("ENTER_PASSWORD", comment: "Enter Password"))
        }
        guard !(_password.isEmpty) else {
            throw ValidateError.invalidData(NSLocalizedString("ENTER_PASSWORD", comment: "Enter Password"))
        }
        
        return true
    }
    
    func authenticateWithFirebaseAuth(email:String?,password:String?, completion:CompletionHandlerWithData?){
        Auth.auth().signIn(withEmail: email!, password: password!){(authResult,error) in
            guard let _authResult = authResult?.user else {
                completion?(false,error?.localizedDescription,nil)
                return
            }
            completion?(true,NSLocalizedString("SUCCESS", comment: "Sign In Successfully!"),_authResult)
        }
    }
}
