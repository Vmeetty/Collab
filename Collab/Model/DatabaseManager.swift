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


class DatabaseManager {
    
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
    

    
    
}
