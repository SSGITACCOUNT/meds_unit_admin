//
//  CloudStorageHelper.swift
//  PharmacyAdminApp
//
//  Created by Shashee on 2024-03-26.
//

import Foundation
import FirebaseStorage

class CloudStorageHelper {
    
    static let shared = CloudStorageHelper()
    
    private let storageRef = Storage.storage().reference()
    
    func uploadFile(data: Data, fileExt: String, complition: @escaping (_ uploadedFileURL: String) -> ()) {
        // Create a reference to the file you want to upload
        let imagePathRef = storageRef.child("uploads/\(UUID().uuidString.replacingOccurrences(of: "-", with: "")).\(fileExt)")
        
        // Create file metadata including the content type
        let metadata = StorageMetadata()
        metadata.contentType = "image/\(fileExt)"
        
        // Upload the file to the path "images/rivers.jpg"
        imagePathRef.putData(data, metadata: metadata) { (metadata, error) in
            // You can also access to download URL after upload.
            imagePathRef.downloadURL { (url, error) in
                guard let downloadURL = url else {
                    // Uh-oh, an error occurred!
                    return
                }
                complition(downloadURL.absoluteString)
            }
        }
    }
}
