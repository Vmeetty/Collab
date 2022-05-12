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
    static let formatNumber       = "+XXXXXXXXXXXX"
    
    struct Segue {
        static let registerSegue  = "RegisterToUsers"
        static let loginSegue     = "LoginToUsers"
        static let profileSegue   = "UsersToProfile"
        static let videoCallSegue = "VIdeoVCSegue"
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
        static let phoneNumber = "number"
    }
    
    struct Firestore {
        static let usersDocument = "users"
        static let metaData      = "image/jpeg"
    }
    
    struct Errors {
        static let gotErr = "Got an erroe:"
    }
    
    struct SettingsAlert {
        static let title      = "Settings"
        static let action1    = "Profile"
        static let action2    = "Sign out"
        static let cancel     = "Dismiss"
        static let storyBoard = "Main"
    }
    
    struct CallAlert {
        static let title   = "Сonfirm the action"
        static let message = "Are you sure you want to call"
        static let yes = "Yes"
        static let no  = "No"
    }
    
    struct ViewControllers {
        static let profileVC = "ProfileViewController"
    }
    
    struct PassAlert {
        static let title   = "Forgot your password?"
        static let message = "We can send a new one on your email"
        static let action1 = "Send"
        static let placeholder = "Write your email here..."
        
    }
}
