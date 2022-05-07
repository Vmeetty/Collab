//
//  UserManager.swift
//  Collab
//
//  Created by user on 07.05.2022.
//

import Foundation
import FirebaseStorage
import FirebaseAuth
import FirebaseCore




class UserManager {
    
    let storage = Storage.storage()
    
    
    
    func loadAllUsers() {
        //...
    }
    
    
    
    func persistImageToStorage(_ image: UIImage?) {
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let uploadRef = storage.reference(withPath: uid)
        
        guard let image = image?.jpegData(compressionQuality: 0.5) else { return }
        
        let uploadMetadata = StorageMetadata.init()
        uploadMetadata.contentType = K.Images.metaData
        
        uploadRef.putData(image, metadata: uploadMetadata) { _, error in
            if let err = error {
                print("Oh no! Got an error: \(err.localizedDescription)")
                return
            }
            uploadRef.downloadURL { url, error in
                if let err = error {
                    print("Faild to retrieve downloadURL: \(err)")
                }
                
                print("Successfully stored image with url: \(url?.absoluteString ?? "")")
            }
        }
    }
    
    
}
