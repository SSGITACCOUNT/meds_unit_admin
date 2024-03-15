//
//  LaunchScreenVC.swift
//  PharmacyAdminApp
//
//  Created by Shashee on 2024-01-26.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class LaunchScreenVC: UIViewController {

    let vm = LaunchScreenVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkIsUserAuthenticatedOnFirebase()
    }
    
    //:MARK check user authentication on firebase
    private func checkIsUserAuthenticatedOnFirebase(){
        vm.checkIsUserAuthenticatedFromFirebase { [weak self] status, message,data in
            guard let _ = self else { return }
            if(status){
                print("***** User Authenticated ******")
                if let _model = data as? User {
                    self?.handleAuthenticatedUser(user: _model)
                }
            }else{
                self?.handleUserNavigation(isUserAuthenticated: status)
                print("***** User Not Authenticated ******")
            }
        }
    }
    
    private func handleAuthenticatedUser(user:User){
        Constants.shared.currentLoggedInFirebaseAuthUser = user
        FirestoreUserManager.shared.getUserDetailsStoredOnFirestoreDb(firebaseUser:user) { status, message, data in
            if (status){
                var firestoreUser =  data as! FirestoreUser
                Constants.shared.currentLoggedInFireStoreUser = firestoreUser
                self.handleNavigationAccordingToUserRole(firestoreUser: firestoreUser)
            }else{
                AlertManager.shared.singleActionMessage(title: "Alert", message: message!, actionButtonTitle: "Ok", vc: self)
            }
        }
    }
    
    func handleUserNavigation(isUserAuthenticated:Bool){
        DispatchQueue.main.asyncAfter(deadline: (.now() + 3)) {
            ApplicationServiceProvider.shared.manageUserDirection(isUserAuthenticated: isUserAuthenticated)
        }
    }
    
    private func handleNavigationAccordingToUserRole(firestoreUser:FirestoreUser){
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
                        self.navigateToHomeVc(isAdmin: true)
                    }else{
                        self.navigateToCreatNewStoreVc()
                    }
                }
            }
        }
    }
    
    
    private func navigateToHomeVc(isAdmin:Bool){
        if(isAdmin){
            let vc = ApplicationServiceProvider.shared.viewController(in: .Main, identifier: "SideMenuConfigurationVC")
            AppDelegate.standard.window?.rootViewController = vc
            
        }else{
            let vc = ApplicationServiceProvider.shared.viewController(in: .Main, identifier: "MainNVC")
            AppDelegate.standard.window?.rootViewController = vc
        }
    }
    
    private func navigateToCreatNewStoreVc(){ // This navigation doesnt work
        let vc = ApplicationServiceProvider.shared.viewController(in: .Auth, identifier: "StoreRegisterVC")
        AppDelegate.standard.window?.rootViewController = vc
    }
}
