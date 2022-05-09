//
//  StorageManager.swift
//  Collab
//
//  Created by user on 09.05.2022.
//

import Foundation
import FirebaseStorage
import FirebaseAuth


class StorageManager {
    
    var uid: String {
        guard let id = Auth.auth().currentUser?.uid else {return UUID.init().uuidString}
        return id
    }
    
    let dbManager = DatabaseManager()
    
    func uploadImage(_ image: UIImage?) {
        let uploadRef = Storage.storage().reference(withPath: "\(uid).jpg")
        guard let image = image?.jpegData(compressionQuality: 0.25) else { return }
        let uploadMetadata = StorageMetadata.init()
        uploadMetadata.contentType = "image/jpeg"
        
        uploadRef.putData(image, metadata: uploadMetadata) { downloadMetadata, error in
            if let error = error {
                print("Got an erroe: \(error)")
            } else {
                print("Put is completed and I got this back: \(downloadMetadata)")
                uploadRef.downloadURL { url, error in
                    if let error = error {
                        print("Got an erroe: \(error)")
                    } else {
                        guard let url = url else { return }
                        print("Successfully stored image with url: \(url.absoluteString)")
                        self.dbManager.updateUserData([K.UserData.imageURLKey: url.absoluteString])
                    }
                }
            }
        }
    }
    
    func downLoadImageWithURL(_ url: String?) {
        if let imageUrl = url {
            let httpsReference = Storage.storage().reference(forURL: imageUrl)
            httpsReference.getData(maxSize: 1 * 1024 * 1024) { data, error in
                if let error = error {
                    print("Got an download erroe: \(error)")
                } else {
                    print("Successfully download data with url")
                    let image = UIImage(data: data!)
                    
                }
            }
        }
    }
    
}
