//
//  Constants.swift
//  Collab
//
//  Created by user on 06.05.2022.
//

import Foundation


struct K {
    static let emailPredicate     = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
    static let passwordPredicate  = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$"
    static let alertSpelingMasage = "Minimum 8 characters at least 1 Alphabet and 1 Number. Add ALERT"
    
    struct Segue {
        static let registerSegue = "RegisterToUsers"
        static let loginSegue    = "LoginToUsers"
    }
    
    struct Id {
        static let cellId = "Cell"
    }
    
    struct Images {
        static let personImage = "person.crop.circle"
        static let videoBubble = "video.bubble.left.fill"
    }
    
    struct UserData {
        static let emailKey    = "email"
        static let passwordKey = "password"
        static let imageURLKey = "imageURL"
        static let nameKey     = "name"
        static let roleKey     = "role"
    }
    
    struct Firestore {
        static let usersDocument = "users"
        static let metaData      = "image/jpeg"
    }
}
