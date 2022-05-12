//
//  LoginViewController.swift
//  Collab
//
//  Created by user on 06.05.2022.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    let auth = Authentication()
    let alerts = Alerts()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        auth.delegate = self

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }


    @IBAction func loginPressed(_ sender: UIButton) {
        auth.loginWithEmail(emailTextField.text, andPassword: passwordTextField.text)
    }
    
    
    @IBAction func forgotPassPresser(_ sender: UIButton) {
        alerts.showFogotPasswordAlert(self)
    }
    
}

extension LoginViewController: AuthenticationDelegate {
    func isAuthenticated(_ user: Bool) {
        if user {
            performSegue(withIdentifier: K.Segue.loginSegue, sender: self)
        }
    }
    
    
}
