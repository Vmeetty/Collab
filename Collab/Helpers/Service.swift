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
        let alert = UIAlertController(title: K.SettingsAlert.title, message: nil, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: K.SettingsAlert.action1, style: .default , handler:{ (UIAlertAction) in
            let storyBoard : UIStoryboard = UIStoryboard(name: K.SettingsAlert.storyBoard, bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: K.ViewControllers.profileVC) as! ProfileViewController
            vc.navigationController?.pushViewController(nextViewController, animated: true)
        }))
        
        alert.addAction(UIAlertAction(title: K.SettingsAlert.action2, style: .default , handler:{ (UIAlertAction) in
            do {
                try Auth.auth().signOut()
                vc.navigationController?.popToRootViewController(animated: true)
            } catch let error as NSError {
                print(error)
            }
        }))
        
        alert.addAction(UIAlertAction(title: K.SettingsAlert.cancel, style: .cancel, handler: nil))
        
        vc.present(alert, animated: true)
    }
    
    
    func configProfileImageView(_ imageView: UIImageView) {
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.cornerRadius = imageView.frame.size.height / 2
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
    }
    
    func configCellButtons(_ imageView: UIImageView) {
        imageView.layer.cornerRadius = imageView.frame.size.height / 2
        imageView.backgroundColor = .white
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.layer.shadowColor = UIColor.black.cgColor
        imageView.layer.shadowOpacity = 1
        imageView.layer.shadowOffset = CGSize.zero
        imageView.layer.shadowRadius = 10
        imageView.layer.shadowPath = UIBezierPath(roundedRect: imageView.bounds, cornerRadius: 10).cgPath
    }
    
    func makeACallWith(number numberStr: String, viewController: UIViewController) {
        if let phoneCallURL = URL(string: "tel:\(numberStr)") {
            let application = UIApplication.shared
            if (application.canOpenURL(phoneCallURL)) {
                let alertController = UIAlertController(title: K.CallAlert.title, message: "\(K.CallAlert.message) \n\(numberStr)?", preferredStyle: .alert)
                let yesPressed = UIAlertAction(title: K.CallAlert.yes, style: .default, handler: { (action) in
                    application.open(phoneCallURL)
                })
                let noPressed = UIAlertAction(title: K.CallAlert.no, style: .default, handler: { (action) in
                    
                })
                alertController.addAction(yesPressed)
                alertController.addAction(noPressed)
                viewController.present(alertController, animated: true, completion: nil)
            }
        }
    }
    
    /// mask : `+XXXXXXXXXXXX`
    func format(with mask: String, phone: String) -> String {
        let numbers = phone.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        var result = ""
        var index = numbers.startIndex
        
        for ch in mask where index < numbers.endIndex {
            if ch == "X" {
                result.append(numbers[index])
                
                index = numbers.index(after: index)
                
            } else {
                result.append(ch)
            }
        }
        return result
    }
    
}
