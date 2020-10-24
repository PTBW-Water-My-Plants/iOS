//
//  ProfileViewController.swift
//  Water My Plants
//
//  Created by Sammy Alvarado on 10/21/20.
//

import UIKit

class ProfileViewController: UIViewController {

    var user: User?
    var wasEdited = false
    var userController: UserController?
    var userName: String?
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItem = editButtonItem
        
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
    
    func getDetails() {
        guard let userController = userController,
              let userName = userName else { return }
        
        userController.fetchUsersDetails(for: userName) { (result) in
            switch result {
            case .success(let user):
                DispatchQueue.main.async {
                    self.updateViews(with: user)
                }
            case .failure(let error):
                print("Error fetching user detials \(error)")
            }
        }
    }
    
    func updateViews(with users: User) {
        usernameTextField.text = users.username
        phoneNumberTextField.text = users.email
        passwordTextField.text = users.password
    }
    
    
    @IBAction func editButtonIsTapped(_ sender: Any) {
    }
    
    @IBAction func saveButtonIsTapped(_ sender: Any) {
    }
    
}
