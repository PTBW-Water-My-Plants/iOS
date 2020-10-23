//
//  AddPlantViewController.swift
//  Water My Plants
//
//  Created by Bohdan Tkachenko on 10/19/20.
//

import UIKit

class AddPlantViewController: UIViewController {
    
    // MARK: Referance
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
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
       
    }
    
    // MARK: - Private
    private func setupDatePicker() {
        countDownTime = UIDatePicker()
        countDownTime?.datePickerMode = .dateAndTime
        countDownTime?.timeZone = .autoupdatingCurrent
        countDownTime?.addTarget(self, action: #selector(AddPlantViewController.dateChanged(datePicker:)), for: .valueChanged)
        
        h20FrequencyTextField.inputView = countDownTime
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(AddPlantViewController.viewTapped(gestureReconizer:)))
        view.addGestureRecognizer(tapGesture)
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
        //Saving data to server
        guard let nickname = nicknameTextField.text, !nickname.isEmpty,
            let date = h20FrequencyTextField.text,
            let species = speciesTextField.text else { return }
        
        let formatter = DateFormatter()
        formatter.timeZone = .current
        formatter.dateFormat = "MM/dd/yy HH:mm a"
        
        let plant = Plant(nickName: nickname, h2oFrequency: 1, species: species)
        plantController?.sendPlantToServer(plant: plant)
        
        do {
            try CoreDataStack.shared.mainContext.save()
            navigationController?.dismiss(animated: true, completion: nil)
            print(plant)
        } catch {
            NSLog("Error saving managed object context with error: \(error)")
        }

        localNotifHelper.requestAuthorizationStatus { success in
            if success == true {
                self.localNotifHelper.scheduleDailyReminderNotification(name: nickname, times: Date(), calendar: Calendar.current)
            }
        }
        tabBarController?.selectedIndex = 1
    }
    
   
}



