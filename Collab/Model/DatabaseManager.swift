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

protocol DatabaseManagerDelegate: AnyObject {
    func getUser(_ newUser: User)
}

class DatabaseManager {
    
    weak var delegate: DatabaseManagerDelegate?
    
    static let shared = DatabaseManager()
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
            }
        }
    }
    
    
    //MARK: - Update a document in collection "users" or creating the document if it does not exist.
    
    func updateUserData(_ userData: [String: Any]) {
        db.collection(K.Firestore.usersDocument).document(uid).setData(userData, merge: true)
    }
    
    
    
    //MARK: - Fetch users
    
    private func decodingData(_ data: [String: Any]) -> User? {
        if let email = data[K.UserData.emailKey] as? String {
            let name = data[K.UserData.nameKey] as? String ?? email
            let role = data[K.UserData.roleKey] as? String ?? ""
            let number = data[K.UserData.phoneNumber] as? String ?? nil
            let imageUrl = data[K.UserData.imageURLKey] as? String
            let newUser = User(name: name, role: role, phoneNumber: number, url: imageUrl)
            return newUser
        } else {
            return nil
        }
    }
    
    // Current user data
    func getCurrentUser(_ complition: @escaping (User) -> ()) {
        let docRef = db.collection(K.Firestore.usersDocument).document(uid)
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                guard let data = document.data() else { return }
                if let newUser = self.decodingData(data) {
                    complition(newUser)
                } else {
                    print("Vlad_Ch. Email not exist")
                    return
                }
            } else {
                print("Document does not exist")
            }
        }
    }
    
    // All users data
    func loadUsers() {
        db.collection(K.Firestore.usersDocument).getDocuments() { [weak self] (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    let data = document.data()
                    if let newUser = self?.decodingData(data) {
                        self?.delegate?.getUser(newUser)
                    } else {
                        print("Vlad_Ch. Email not exist")
                        return
                    }
                }
            }
        }
    }
    
    
    
    
    //MARK: - Storage section
    
    func getImageWithURL(_ url: String?, setResultInto imageView: UIImageView) {
        if let imageUrl = url {
            let httpsReference = Storage.storage().reference(forURL: imageUrl)
            httpsReference.getData(maxSize: 1 * 1024 * 1024) { data, error in
                if let error = error {
                    print("Got an download erroe: \(error)")
                } else {
                    imageView.image = UIImage(data: data!)
                }
            }
        } else {
            imageView.image = UIImage(systemName: K.Images.personImage)
        }
    }
    
    
    func uploadImage(_ image: UIImage?) {
        let uploadRef = Storage.storage().reference(withPath: "\(uid).jpg")
        guard let image = image?.jpegData(compressionQuality: 0.25) else { return }
        let uploadMetadata = StorageMetadata.init()
        uploadMetadata.contentType = K.Firestore.metaData
        
        uploadRef.putData(image, metadata: uploadMetadata) { downloadMetadata, error in
            if let error = error {
                print("\(K.Errors.gotErr) \(error)")
            } else {
                uploadRef.downloadURL { url, error in
                    if let error = error {
                        print("Got an erroe: \(error)")
                    } else {
                        guard let url = url else { return }
                        self.updateUserData([K.UserData.imageURLKey: url.absoluteString])
                    }
                }
            }
        }
    }
}
