//
//  ProfileViewController.swift
//  Water My Plants
//
//  Created by Sammy Alvarado on 10/21/20.
//

import UIKit

class ProfileViewController: UIViewController {

    var plant: Plant?
    var wasEdited = false
    var watermyPlantController: WaterMyPlantController?
    
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
    
    
    @IBAction func editButtonIsTapped(_ sender: Any) {
    }
    
    @IBAction func saveButtonIsTapped(_ sender: Any) {
    }
    
}
