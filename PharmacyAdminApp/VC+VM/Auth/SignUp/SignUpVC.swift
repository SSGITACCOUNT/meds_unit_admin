//
//  SignUpVC.swift
//  PharmacyAdminApp
//
//  Created by Shashee on 2024-02-27.
//

import UIKit

class SignUpVC: UIViewController {

    @IBOutlet weak var fullNameTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var phoneNumberTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    
    let vm = SignUpVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func userSignUpAction() {
        vm.createNewUserOnFirebase(fullName: fullNameTxt.text, email: emailTxt.text, phoneNumber: phoneNumberTxt.text, password: passwordTxt.text, confirmPassword: confirmPassword.text) { [weak self] status, message, data in
            guard let _ = self else { return }            
        }
    }
    

    @IBAction func signUpAction(_ sender: Any) {
        userSignUpAction()
    }
}
