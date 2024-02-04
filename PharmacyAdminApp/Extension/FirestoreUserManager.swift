//
//  FirestoreUserManager.swift
//  PharmacyAdminApp
//
//  Created by Shashee on 2024-02-01.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore


class FirestoreUserManager {
    static let shared: FirestoreUserManager = {
        let _shared = FirestoreUserManager()
        return _shared
    }()
    
    
    /**
     This is used to map the newly signed up user data between firestore auth and firestore db
     */
    func storeSignedUpUserDetailsOnFirestoreDb(firebaseUser:User,firestoreUser:FirestoreUser,completionWithPayload:CompletionHandlerWithData?){
        let userId = firebaseUser.uid
        
        let firestoreDocRef =   Firestore.firestore().collection(FirestoreCollections.users.rawValue).document(userId)
        guard let firestoreUserAsDictionary = firestoreUser.getDictionary() else {
            completionWithPayload?(false,"Failed to Encode New User Object ",nil)
            return
        }
        firestoreDocRef.setData(firestoreUserAsDictionary) { err in
            if let err = err {
                completionWithPayload?(false,err.localizedDescription,nil)
                print("Error writing document: \(err)")
            } else {
                completionWithPayload?(true,nil,nil)
                print("Document successfully written!")
            }
        }
    }
    
    func storeDetailsOnFirestoreDb(firestoreUser:FirestorePharmacyStore,completionWithPayload:CompletionHandlerWithData?){
        let currentUser =  Auth.auth().currentUser?.uid ?? ""
        let firestoreDocRef =   Firestore.firestore().collection(FirestoreCollections.stores.rawValue).document(currentUser)
        guard let firestoreUserAsDictionary = firestoreUser.getDictionary() else {
            completionWithPayload?(false,"Failed to Encode New User Object ",nil)
            return
        }
        firestoreDocRef.setData(firestoreUserAsDictionary) { err in
            if let err = err {
                completionWithPayload?(false,err.localizedDescription,nil)
                print("Error writing document: \(err)")
            } else {
                completionWithPayload?(true,nil,nil)
                print("Document successfully written!")
            }
        }
    }
    /**
     This is used to  fetch the user data related to the FirebaseUser which is stored on  Firestore Db     */
    func getUserDetailsStoredOnFirestoreDb(firebaseUser:User,completionWithPayload:CompletionHandlerWithData?){
        let userId = firebaseUser.uid
        let userDetailsDocumentRef = Firestore.firestore().collection(FirestoreCollections.users.rawValue).document(userId)
        userDetailsDocumentRef.getDocument { document, error in
            if let error = error as NSError? {
                var errorMessage = "Error getting document: \(error.localizedDescription)"
                completionWithPayload?(false,errorMessage,nil)
            }else {
                if let _userDataDictoanary = document?.data() {
                    do {
                       var firestoreUser =  FirestoreUser(dictionary: _userDataDictoanary)
                        completionWithPayload?(true,nil,firestoreUser)
                    }
                    catch let exception {
                        print(error)
                    }
                }
            }
        }
    }
    
}

