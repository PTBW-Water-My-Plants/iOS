//
//  AddPlantViewController.swift
//  Water My Plants
//
//  Created by Bohdan Tkachenko on 10/19/20.
//

import UIKit

class AddPlantViewController: UIViewController {
    
    // MARK: - Properties and Outlets
    var wasEdited = false
    
    //Referance
    var plantController: WaterMyPlantController?
    var plant: PlantRepresentation?
    let localNotifHelper = LocalNotificationHelper()
    
    // MARK: - Outlets
    @IBOutlet weak var nicknameTextField: UITextField!
    @IBOutlet weak var speciesTextField: UITextField!
    @IBOutlet weak var h20FrequencyTextField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var sameraButton: UIButton!
    private var countDownTime: UIDatePicker?
    
    // MARK: - View Loading
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDatePicker()
        navigationItem.rightBarButtonItem = editButtonItem

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if wasEdited {
           // Setup Editing Feature
        }
    }
    
    
    
    
    //MARK: - Private

    
    
    private func setupDatePicker() {
        countDownTime = UIDatePicker()
        countDownTime?.datePickerMode = .countDownTimer
        countDownTime?.timeZone = .autoupdatingCurrent
        countDownTime?.addTarget(self, action: #selector(AddPlantViewController.dateChanged(datePicker:)), for: .valueChanged)
        
        h20FrequencyTextField.inputView = countDownTime
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(AddPlantViewController.viewTapped(gestureReconizer:)))
        view.addGestureRecognizer(tapGesture)
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
         super.setEditing(editing, animated: animated)
         
         if editing { wasEdited = true }
         
         nicknameTextField.isUserInteractionEnabled = editing
         speciesTextField.isUserInteractionEnabled = editing
         h20FrequencyTextField.isUserInteractionEnabled = editing
         navigationItem.hidesBackButton = editing
     }
    
    @objc func dateChanged(datePicker: UIDatePicker) {
          let formatter = DateFormatter()
          formatter.dateFormat = "MM/dd/yy HH:mm a"
          
          h20FrequencyTextField.text = formatter.string(from: datePicker.date)
      }
    
    @objc func viewTapped(gestureReconizer: UITapGestureRecognizer) {
           view.endEditing(true)
       }
    
    // MARK: -  Actions
    @IBAction func saveButtonTapped(_ sender: Any) {
//        guard let name = nicknameTextField.text,
//              !name.isEmpty,
//              let species = speciesTextField.text,
//              !description.isEmpty else { return }
//        let times = countDownTime?.date
//
//        localNotifHelper.requestAuthorizationStatus { success in
//            if success == true {
//                self.localNotifHelper.scheduleDailyReminderNotification(name: name, times: times!, calendar: Calendar.current)
//            }
//        }
    }
}



