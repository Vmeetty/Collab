//
//  ProfileViewController.swift
//  Collab
//
//  Created by user on 07.05.2022.
//

import UIKit
import PhotosUI

class ProfileViewController: UIViewController {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var roleTextField: UITextField!
    
    let userManager = UserManager()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        profileImageView.addGestureRecognizer(tapGR)
        profileImageView.isUserInteractionEnabled = true
        
        
    }
    
    
    @objc func imageTapped() {
        presentPicker()
    }

    
}

extension ProfileViewController: PHPickerViewControllerDelegate {
    
    private func presentPicker() {
        let photoLibrary = PHPhotoLibrary.shared()
        let configuration = PHPickerConfiguration(photoLibrary: photoLibrary)
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        present(picker, animated: true)
    }
    
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        
        picker.dismiss(animated: true)
                    
        if let itemProvider = results.first?.itemProvider {
            itemProvider.loadObject(ofClass: UIImage.self) { [weak self] image, error in
                if let image = image as? UIImage {
                    guard let self = self else { return }
                    DispatchQueue.main.async {
                        self.profileImageView.layer.borderWidth = 5
                        self.profileImageView.layer.cornerRadius = self.profileImageView.frame.size.height / 2
                        self.profileImageView.clipsToBounds = true
                        self.profileImageView.contentMode = .scaleAspectFill
                        self.profileImageView.image = image
                    }
                    self.userManager.persistImageToStorage(image)
                }
                if let error = error {
                    print(error)
                    return
                }
            }
        }
        
    }
    
}




