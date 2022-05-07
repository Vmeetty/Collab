//
//  SplashViewController.swift
//  Collab
//
//  Created by user on 06.05.2022.
//

import UIKit
import RevealingSplashView

class SplashViewController: UIViewController {

    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let revealingSplashView = RevealingSplashView(iconImage: UIImage(systemName: K.videoBubble)! ,iconInitialSize: CGSize(width: 130, height: 130), backgroundColor: UIColor(red: 0.15, green: 0.26, blue: 0.28, alpha: 1.00))
        self.view.addSubview(revealingSplashView)
        revealingSplashView.animationType = SplashAnimationType.woobleAndZoomOut
        revealingSplashView.startAnimation()
        
        loginButton.layer.cornerRadius = 60
        registerButton.layer.cornerRadius = 60
        
        
    }

    
    
}

