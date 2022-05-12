//
//  Alerts.swift
//  Collab
//
//  Created by user on 09.05.2022.
//

import Foundation
import UIKit
import FirebaseAuth

class Alerts {
    
    let auth = Authentication()
    
    public func showFogotPasswordAlert(_ sender: UIViewController) {
        let alert = UIAlertController(title: K.PassAlert.title, message: K.PassAlert.message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: K.PassAlert.action1, style: .default) { alertAction in
            if let email = alert.textFields![0].text {
                if email.isValidEmail {
                    self.auth.passwordResset(with: email)
                }
            }
        }
        alert.addAction(action)
        alert.addTextField { alertTextField in
            alertTextField.placeholder = K.PassAlert.placeholder
        }
        sender.present(alert, animated: true, completion: nil)
    }
    
}
