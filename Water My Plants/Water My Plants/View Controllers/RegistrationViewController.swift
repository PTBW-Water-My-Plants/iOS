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
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    var image: UIImage? = nil
    let authServices = AuthServices()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUserImageView()

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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func signUpButtonTapped(_ sender: Any) {
        self.view.endEditing(true)
                guard let username = usernameTextField.text, !username.isEmpty else { return }
                guard let email = emailTextField.text, !email.isEmpty else { return }
                guard let password = passwordTextField.text, !password.isEmpty else { return }
                authServices.signUp(withUsername: username, email: email, password: password, image: self.image, onSuccess: {
                    print("Done")
                }) { (errorMessage) in
                    print(errorMessage)
                }
                performSegue(withIdentifier: "SignUpSegue", sender: nil)
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
