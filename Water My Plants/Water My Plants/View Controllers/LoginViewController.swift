//
//  LoginViewController.swift
//  Water My Plants
//
//  Created by Sammy Alvarado on 10/15/20.
//

import UIKit

class LoginViewController: UIViewController {

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

}

/*
 
 enum LoginType {
     case signUp
     case signIn
 }

 class LoginViewController: UIViewController, UITextFieldDelegate {
     
     @IBOutlet private weak var usernameTextField: UITextField!
     @IBOutlet private weak var passwordTextField: UITextField!
     @IBOutlet private weak var loginTypeSegmentedControl: UISegmentedControl!
     @IBOutlet private weak var signInButton: UIButton!
     
     var apiController: APIController?
     var loginType = LoginType.signUp

     override func viewDidLoad() {
         super.viewDidLoad()

         signInButton.backgroundColor = UIColor(hue: 190/360, saturation: 70/100, brightness: 80/100, alpha: 1.0)
         signInButton.tintColor = .white
         signInButton.layer.cornerRadius = 8.0
     }
     
     // MARK: - Action Handlers
     
     @IBAction func buttonTapped(_ sender: UIButton) {
         // perform login or sign up operation based on loginType
         if let username = usernameTextField.text,
             !username.isEmpty,
             let password = passwordTextField.text,
             !password.isEmpty {
             let user = User(username: username, password: password)

             switch loginType {
             case .signUp:
                 apiController?.signUp(with: user, completion: { (result) in
                     do {
                         let success = try result.get()
                         if success {
                         DispatchQueue.main.async {
                             let alertController = UIAlertController(title: "Sign Up Successful", message: "Now please log in.", preferredStyle: .alert)
                             let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                             alertController.addAction(alertAction)
                             self.present(alertController, animated: true) {
                                 self.loginType = .signIn
                                 self.loginTypeSegmentedControl.selectedSegmentIndex = 1
                                 self.signInButton.setTitle("Sign In", for: .normal)
                             }
                         }
                     }
                     } catch {
                         print("Error signign up: \(error)")
                     }
                 })
             case .signIn:
                 apiController?.signIn(with: user, completion: { (result) in
                     do {
                         let success = try result.get()
                         if success {
                             DispatchQueue.main.async {
                                 self.dismiss(animated: true, completion: nil)
                             }
                         }
                     } catch {
                         if let error = error as? APIController.NetworkError {
                             switch error {
                             case .failedSignIn:
                                 print("Sign in Failed")
                             case .noData, .noToken:
                                 print("No data received")
                             default:
                                 print("other errro Occurred")
                             }
                         }
                     }
                 })
             }
         }
     }
     
     @IBAction func signInTypeChanged(_ sender: UISegmentedControl) {
         // switch UI between login types
         if sender.selectedSegmentIndex == 0 {
             loginType = .signUp
             signInButton.setTitle("Sign Up", for: .normal)
         } else {
             loginType = .signIn
             signInButton.setTitle("Sign In", for: .normal)
         }
     }
 }


 
 */
