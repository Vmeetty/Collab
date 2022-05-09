//
//  Service.swift
//  Collab
//
//  Created by user on 08.05.2022.
//

import UIKit
import FirebaseAuth

class Service {
    
    static let shared = Service()
    
    func showActionSheetBy(viewController vc: UIViewController) {
        let alert = UIAlertController(title: "Settings", message: nil, preferredStyle: .actionSheet)
            
            alert.addAction(UIAlertAction(title: "Profile", style: .default , handler:{ (UIAlertAction)in
                vc.performSegue(withIdentifier: K.Segue.profileSegue, sender: vc)
            }))
            
            alert.addAction(UIAlertAction(title: "Sign out", style: .default , handler:{ (UIAlertAction)in
                do {
                    try Auth.auth().signOut()
                    vc.navigationController?.popToRootViewController(animated: true)
                } catch let error as NSError {
                    print(error)
                }
            }))
        
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))

            vc.present(alert, animated: true, completion: {
                print("completion block")
            })
    }
    
    
    func configProfileImageView(_ imageView: UIImageView) {
        imageView.layer.borderWidth = 5
        imageView.layer.cornerRadius = imageView.frame.size.height / 2
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
    }
    
}
