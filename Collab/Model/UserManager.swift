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
import FirebaseFirestore




class UserManager {
    
    let storage = Storage.storage()
    let db = Firestore.firestore()
    
    var uid: String {
        guard let id = Auth.auth().currentUser?.uid else {return UUID.init().uuidString}
        return id
    }
    
    
    
    //MARK: - Add a new document in collection "users"
    
    func persistNewUserWithEmail(_ email: String?) {
        
        guard let email = email else { return }

        let userData: [String: Any] = [K.UserData.emailKey: email]
        db.collection(K.Firestore.usersDocument).document(uid).setData(userData) { err in
            if let err = err {
                print("Error writing document: \(err.localizedDescription)")
                return
            } else {
                print("Document successfully written!")
            }
        }
    }
    
    
    //MARK: - Update a document in collection "users" or creating the document if it does not exist.
    
    func updateUserData(_ userData: [String: Any]) {
        db.collection(K.Firestore.usersDocument).document(uid).setData(userData, merge: true)
    }
    
    
    
    //MARK: - Add a new image to storage
    
    func persistImageToStorage(_ image: UIImage?) {
        
        let uploadRef = storage.reference(withPath: uid)
        
        guard let image = image?.jpegData(compressionQuality: 0.5) else { return }
        
        let uploadMetadata = StorageMetadata.init()
        uploadMetadata.contentType = K.Firestore.metaData
        
        uploadRef.putData(image, metadata: uploadMetadata) { _, error in
            if let err = error {
                print("Oh no! Got an error: \(err.localizedDescription)")
                return
            }
            uploadRef.downloadURL { url, error in
                if let err = error {
                    print("Faild to retrieve downloadURL: \(err.localizedDescription)")
                    return
                }
                guard let url = url else { return }
                print("Successfully stored image with url: \(url.absoluteString)")
                
                self.updateUserData([K.UserData.imageURLKey: url.absoluteString])
            }
        }
    }
    
    
}
