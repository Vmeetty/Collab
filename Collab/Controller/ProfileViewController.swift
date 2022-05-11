//
//  ProfileViewController.swift
//  Collab
//
//  Created by user on 07.05.2022.
//

import UIKit
import PhotosUI
import FirebaseAuth
import FirebaseStorage

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var roleTextField: UITextField!
    @IBOutlet weak var phoneNumber: UITextField!
    
    let service = Service()
    var urlStr: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        profileImageView.addGestureRecognizer(tapGR)
        profileImageView.isUserInteractionEnabled = true
        
        nameTextField.delegate = self
        roleTextField.delegate = self
        phoneNumber.delegate = self
        service.configProfileImageView(profileImageView)
        
        DatabaseManager
            .shared
            .getCurrentUser { user in
                self.nameTextField.text = user.name
                self.roleTextField.text = user.role
                self.phoneNumber.text = user.phoneNumber
                self.urlStr = user.url
            
            DatabaseManager
                .shared
                .getImageWithURL(self.urlStr, setResultInto: self.profileImageView)
        }
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
                        self.service.configProfileImageView(self.profileImageView)
                        self.profileImageView.image = image
                    }
                    DatabaseManager.shared.uploadImage(image)
                }
                if let error = error {
                    print(error)
                    return
                }
            }
        }
    }
}


extension ProfileViewController: UITextFieldDelegate {
    
    private func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let value = textField.text, !value.isEmpty else { return }
        var key = ""
        switch textField {
        case nameTextField: key = K.UserData.nameKey
        case roleTextField: key = K.UserData.roleKey
        case phoneNumber:   key = K.UserData.phoneNumber
        default: break
        }
        DatabaseManager.shared.updateUserData([key: value])
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return false }
        let newString = (text as NSString).replacingCharacters(in: range, with: string)
        textField.text = Service.shared.format(with: K.formatNumber, phone: newString)
        return false
    }
}



