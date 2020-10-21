//
//  LoginViewController.swift
//  Water My Plants
//
//  Created by Sammy Alvarado on 10/18/20.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!

    let authServices = AuthServices()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.setNavigationBarHidden(true, animated: false)
        passwordTextField.isSecureTextEntry = true
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func logInButtonTapped(_ sender: Any) {
        
        guard let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty,
              let username = usernameTextField.text, !username.isEmpty else { return }
        
        Auth.auth().signIn(withEmail: email, password: password) { AuthDataResult, error in
            if error != nil {
                print("Failed to make a login")
                return
            }
            print("Was able to log in to the home view")
            self.performSegue(withIdentifier: "LoginHomeView", sender: nil)
        }
        
        if emailTextField.text == "" {
            loginButton.isHidden = true
        }
//        emailTextField.text = ""
//        passwordTextField.text = ""
    }
    
    func disableLoginButton() {
        let email = emailTextField.text, password = passwordTextField.text, username = usernameTextField.text

        if ((email?.isEmpty) != nil), ((password?.isEmpty) != nil), ((username?.isEmpty) != nil) {
            loginButton.isEnabled = false
        }
    }
    
}
