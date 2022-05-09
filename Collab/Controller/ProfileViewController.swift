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
    
    var uid: String {
        guard let id = Auth.auth().currentUser?.uid else {return UUID.init().uuidString}
        return id
    }
    
    let userManager = UserManager()
    let service     = Service()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        profileImageView.addGestureRecognizer(tapGR)
        profileImageView.isUserInteractionEnabled = true
        nameTextField.delegate = self
        roleTextField.delegate = self
        service.configProfileImageView(profileImageView)
        userManager.downloadImageTo(imageView: profileImageView)
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
                    self.userManager.persistImageToStorage(image)
                }
                if let error = error {
                    print(error)
                    return
                }
            }
        }
    }
    
//    func downloadImage() {
//        // Create a reference to the file you want to download
//        let islandRef = Storage.storage().reference().child("\(uid)")
//
//        // Download in memory with a maximum allowed size of 1MB (1 * 1024 * 1024 bytes)
//        islandRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
//            if let error = error {
//                // Uh-oh, an error occurred!
//            } else {
//                // Data for "images/island.jpg" is returned
//                if let image = UIImage(data: data!) {
//                    self.profileImageView.image = image
//                }
//            }
//        }
//    }
        
}


extension ProfileViewController: UITextFieldDelegate {
    
    private func textFieldShouldReturn(textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            return true
        // Keyboard doesn't dissmis ****************=--=-=-=-=-=-=**********************777777**(&&(*&(*&(&(&
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
        default: break
        }
        userManager.updateUserData([key: value])
    }
}


