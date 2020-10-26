//
//  LoginViewController.swift
//  Water My Plants
//
//  Created by Sammy Alvarado on 10/18/20.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    var handle: AuthStateDidChangeListenerHandle?
    
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.navigationController?.isNavigationBarHidden = true
//
//        navigationController?.setNavigationBarHidden(true, animated: false)
        passwordTextField.isSecureTextEntry = true
        handle = Auth.auth().addStateDidChangeListener({ (auth, user) in
        })
        if Auth.auth().currentUser != nil {
            let storyboard = UIStoryboard(name: "HomeView", bundle: Bundle.main)
            guard
                let tabBar = storyboard.instantiateViewController(identifier: "TabBarController") as? UITabBarController
            else { return }
            navigationController?.present(tabBar, animated: true, completion: nil)
        }

    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        Auth.auth().removeStateDidChangeListener(handle!)
    }
    
    @IBAction func logInButtonTapped(_ sender: Any) {
        guard
            let email = emailTextField.text, !email.isEmpty,
            let password = passwordTextField.text, !password.isEmpty,
            let username = usernameTextField.text, !username.isEmpty
        else { return }
        
        AuthServices.shared.signin(email: email, password: password, phone: "", image: UIImage()) { (result) in
            switch result {
            case .success(let success):
                print("Was successfule sign in: \(success)")
                self.performSegue(withIdentifier: "LoginHomeView", sender: nil)
            case .failure(let error):
                DispatchQueue.main.async {
                    self.presentUserInfoAlert(title: "Error", message: "\(error.localizedDescription)")
                }
                print("Failed to sign in: \(error)")
            }
        }
    }
}
