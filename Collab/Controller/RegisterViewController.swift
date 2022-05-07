//
//  RegisterViewController.swift
//  Collab
//
//  Created by user on 06.05.2022.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    let auth = Authentication()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }


    @IBAction func registerPressed(_ sender: UIButton) {
        auth.registerWithEmail(emailTextField.text, andPassword: passwordTextField.text)
    }
    
}


