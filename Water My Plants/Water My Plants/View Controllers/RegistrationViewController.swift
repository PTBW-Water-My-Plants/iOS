//
//  LoginViewController.swift
//  Water My Plants
//
//  Created by Sammy Alvarado on 10/15/20.
//

import UIKit
import Firebase

class RegistrationViewController: UIViewController {
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    
    var image: UIImage? = nil
    var userController: UserController?
    
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUserImageView()
        
        self.navigationController?.isNavigationBarHidden = true

        navigationController?.setNavigationBarHidden(true, animated: false)
        passwordTextField.isSecureTextEntry = true
    }
    
    func setupUserImageView() {
        userImageView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(presentPicker))
        userImageView.addGestureRecognizer(tapGesture)
    }
    @objc func presentPicker() {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        picker.delegate = self
        self.present(picker, animated: true, completion: nil)
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let userDictionary = ["user": self.user]
        NotificationCenter.default.post(name: .sendUserInfo, object: nil, userInfo: userDictionary)
    }
    
    
    @IBAction func signUpButtonTapped(_ sender: Any) {
        self.view.endEditing(true)
        guard
            let email = emailTextField.text, !email.isEmpty,
            let phoneNumber = phoneNumberTextField.text, !email.isEmpty,
            let password = passwordTextField.text, !password.isEmpty
        else { return }
        let user = User(password: password, email: email, image: userImageView.image, phone: phoneNumber)
        self.user = user
        AuthServices.shared.registration(withUsername: email, password: password, phoneNumber: phoneNumber, image: userImageView.image ?? UIImage()) { (result) in
            switch result {
            case .success(let success):
                print("Was successfule sign up: \(success)")
                self.performSegue(withIdentifier: "SignUpSegue", sender: nil)
            case .failure(let error):
                print("Failed to sign up: \(error)")
            }
        }
    }
}

extension RegistrationViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let imageSelected = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
                image = imageSelected
                userImageView.image = imageSelected
            }
            if let imageOriginal = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                image = imageOriginal
                userImageView.image = imageOriginal
            }
            picker.dismiss(animated: true, completion: nil)
        }
}
