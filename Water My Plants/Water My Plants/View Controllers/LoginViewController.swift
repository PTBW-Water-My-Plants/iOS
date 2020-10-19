//
//  LoginViewController.swift
//  Water My Plants
//
//  Created by Sammy Alvarado on 10/18/20.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
        guard let email = emailTextField.text, !email.isEmpty else { return }
                guard let password = passwordTextField.text, !password.isEmpty else { return }
                Auth.auth().signIn(withEmail: email, password: password) { (AuthDataResult, error) in
                    if error != nil {
                        print("Crap")
                        return
                    }
                    print("Work")
                    self.performSegue(withIdentifier: "loginGoToTabBarSegue", sender: nil)
                }
                emailTextField.text = ""
                passwordTextField.text = ""
    }
    
}
