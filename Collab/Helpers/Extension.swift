//
//  Extension.swift
//  Collab
//
//  Created by user on 09.05.2022.
//

import Foundation
import UIKit
import FirebaseStorage

let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    
    func loadImageUsingCashWithUrlString(urlString: String) {
        if let cachedImage = imageCache.object(forKey: urlString as NSString) as? UIImage {
            self.image = cachedImage
            return
        }
        let httpsReference = Storage.storage().reference(forURL: urlString)
        httpsReference.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if let error = error {
                print("Got an download error: \(error)")
            } else {
                print("Successfully download data with url")
                if let downloadedImage = UIImage(data: data!) {
                    imageCache.setObject(downloadedImage, forKey: urlString as NSString)
                    self.image = downloadedImage
                }
            }
        }
    }
}
