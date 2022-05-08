//
//  Authentication.swift
//  Collab
//
//  Created by user on 07.05.2022.
//

import Foundation
import FirebaseAuth

protocol AuthenticationDelegate {
    func isAuthenticated(_ user: Bool)
}

class Authentication {
    
    var delegate: AuthenticationDelegate?
    
    func registerWithEmail(_ email: String?, andPassword password: String?) {
        
        if let email = email, let password = password {
            if email.isValidEmail && password.isValidPassword {
                Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                    if let err = error {
                        print(err)
                        self.delegate?.isAuthenticated(false)
                    } else if authResult != nil {
                        self.delegate?.isAuthenticated(true)
                    }
                }
            } else {
                print(K.alertSpelingMasage)
            }
        }
    }
    
    
    func loginWithEmail(_ email: String?, andPassword password: String?) {
        
        if let email = email, let password = password {
            if email.isValidEmail && password.isValidPassword {
                Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                    if let err = error {
                        print(err)
                        self.delegate?.isAuthenticated(false)
                    } else if authResult != nil {
                        self.delegate?.isAuthenticated(true)
                    }
                }
            } else {
                print(K.alertSpelingMasage)
            }
        }
    }
    
    
}

extension String {
    
    var isValidEmail: Bool {
        NSPredicate(format: "SELF MATCHES %@",
                    K.emailPredicate).evaluate(with: self)
    }
    
    var isValidPassword: Bool {
        NSPredicate(format: "SELF MATCHES %@",
                    K.passwordPredicate).evaluate(with: self)
    }
}
