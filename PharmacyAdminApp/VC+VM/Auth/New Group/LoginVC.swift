//
//  LoginVC.swift
//  PharmacyAdminApp
//
//  Created by Shashee on 2024-03-14.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class LoginVC: UIViewController {

    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    
    let vm = LoginVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func validateSignInForm() {
//        RappleActivityIndicatorView.startAnimating()
        vm.validateSignInForm(email: emailTxt.text, password: passwordTxt.text) { status, message in
            let _errorMsg = message ?? "Something Went Wrong"
            if(status){
                vm.authenticateWithFirebaseAuth(email: emailTxt.text, password: passwordTxt.text) { status, message,data in
                    let _errorMsg = message ?? "Something Went Wrong"
                    if(status){
                        guard  let _user = data as? User else{
//                            RappleActivityIndicatorView.stopAnimation()
                            AlertManager.shared.singleActionMessage(title: "Alert", message: _errorMsg, actionButtonTitle: "Ok", vc: self)
                            return
                        }
                        Constants.shared.currentLoggedInFirebaseAuthUser = _user
                        FirestoreUserManager.shared.getUserDetailsStoredOnFirestoreDb(firebaseUser:_user) { status, message, data in
                            if (status){
                                var firestoreUser =  data as! FirestoreUser
                                Constants.shared.currentLoggedInFireStoreUser = firestoreUser
                                self.checkStoreAvailabilityAndNavigate(firestoreUser: firestoreUser)
                            }else{
//                                RappleActivityIndicatorView.stopAnimation()
                                AlertManager.shared.singleActionMessage(title: "Alert", message: message!, actionButtonTitle: "Ok", vc: self)
                            }
                        }
                    }else{
//                        RappleActivityIndicatorView.stopAnimation()
                        AlertManager.shared.singleActionMessage(title: "Alert", message: _errorMsg, actionButtonTitle: "Ok", vc: self)
                    }
                }
            }else{
//                RappleActivityIndicatorView.stopAnimation()
                AlertManager.shared.singleActionMessage(title: "Alert", message: _errorMsg, actionButtonTitle: "Ok", vc: self)
            }
        }
    }
    
    private func checkStoreAvailabilityAndNavigate(firestoreUser:FirestoreUser){
        let userId = firestoreUser.id
        let storeOfAdminUserDocumentRef = Firestore.firestore().collection(FirestoreCollections.stores.rawValue).document(userId)
        storeOfAdminUserDocumentRef.getDocument { document, error in
            if let error = error as NSError? {
                var errorMessage = "Error getting document: \(error.localizedDescription)"
                AlertManager.shared.singleActionMessage(title: "Alert", message: errorMessage, actionButtonTitle: "Ok", vc: self)
            }else {
                if let _storeDataDictoanary = document?.data() {
                    var firestorePharmacyStore =  FirestorePharmacyStore(dictionary: _storeDataDictoanary)
                    if(firestorePharmacyStore != nil){
                        self.navigateToHomeVc()
                    }else{
                        self.navigateToCreatNewStoreVc()
                    }
                }
            }
        }
    }
    
    private func navigateToHomeVc(){
        let vc = ApplicationServiceProvider.shared.viewController(in: .Main, identifier: "MainNVC")
        AppDelegate.standard.window?.rootViewController = vc
    }
    
    private func navigateToCreatNewStoreVc() {
        let vc = ApplicationServiceProvider.shared.viewController(in: .Auth, identifier: "StoreRegisterVC")
        AppDelegate.standard.window?.rootViewController = vc
    }
    
    @IBAction func loginAction(_ sender: Any) {
        validateSignInForm()
    }
    
    @IBAction func signupAction(_ sender: Any) {
    }
}
