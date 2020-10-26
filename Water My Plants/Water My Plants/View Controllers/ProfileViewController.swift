//
//  ProfileViewController.swift
//  Water My Plants
//
//  Created by Sammy Alvarado on 10/21/20.
//

import UIKit
import FirebaseAuth


class ProfileViewController: UIViewController {
    
    
    var handle: AuthStateDidChangeListenerHandle?

    var user: User?
    var wasEdited = false
    var userController: UserController?
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.navigationController?.isNavigationBarHidden = true
//        navigationController?.setNavigationBarHidden(true, animated: false)
        
        self.user = AuthServices.shared.currentUser
        navigationItem.rightBarButtonItem = editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        handle = Auth.auth().addStateDidChangeListener({ (auth, user) in
            if let user = user {
                self.usernameTextField.text = user.email
            }
            
//            if let user = user {
//                self.phoneNumberTextField.text = user.phoneNumber
//            }
    
        })
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        Auth.auth().removeStateDidChangeListener(handle!)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

//        if wasEdited {
//            guard let username = usernameTextField.text,
//                !username.isEmpty,
//                let plant = plant else { return }
//
//            let phoneNumber = phoneNumberTextField.text
//            plant.name = name
//            task.notes = notes
//            let priorityIndex = prioritySegmentedControl.selectedSegmentIndex
//            task.priority = TaskPriority.allCases[priorityIndex].rawValue
//            taskController?.sendTaskToServer(task: task)
//            do {
//                try CoreDataStack.shared.mainContext.save()
//            } catch {
//                NSLog("Error saving managed object context")
//            }
//        }
    }
    
    
    func updateViews(with users: User) {
        phoneNumberTextField.text = users.email
        passwordTextField.text = users.password
    }
    
    @IBAction func signOut(_ sender: Any) { 
        AuthServices.shared.signOut { (success) in
            if success {
                self.navigationController?.popToRootViewController(animated: true)
            }
        }
    }
    
    @IBAction func editButtonIsTapped(_ sender: Any) {
    }
    
    @IBAction func saveButtonIsTapped(_ sender: Any) {
    }
    
}
