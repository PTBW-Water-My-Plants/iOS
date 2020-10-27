//
//  AddPlantViewController.swift
//  Water My Plants
//
//  Created by Bohdan Tkachenko on 10/19/20.
//

import UIKit

class AddPlantViewController: UIViewController {
    
    // MARK: Referance
    var plantController = WaterMyPlantController()
    var plant: PlantRepresentation?
    let localNotifHelper = LocalNotificationHelper()
    
    // MARK: - Outlets
    @IBOutlet weak var nicknameTextField: UITextField!
    @IBOutlet weak var speciesTextField: UITextField!
    @IBOutlet weak var h20FrequencyTextField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var cameraButton: UIButton!
    private var countDownTime: UIDatePicker?
    var imagePicker = UIImagePickerController()
    var dateFromDatePicker = Date()
    
    // MARK: - View Loading
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDatePicker()
        
        cameraButton.addTarget(self, action: #selector(presentPicker), for: .touchUpInside)
        imagePicker.delegate = self
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
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        dateFromDatePicker = datePicker.date
        h20FrequencyTextField.text = formatter.string(from: datePicker.date)
    }
    
    @objc func viewTapped(gestureReconizer: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    // MARK: -  Actions
    
    @IBAction func cameraButtonTapped(_ sender: Any) {
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        //Saving data to server
        guard let nickname = nicknameTextField.text, !nickname.isEmpty,
              let date = h20FrequencyTextField.text,
              let species = speciesTextField.text,
              let image = imageView.image?.jpegData(compressionQuality: 0.5) else { return }
        
        
        var plant = Plant()
        plantController.uploadImageData(with: image) { (result) in
            switch result {
            case .success(let urlString):
                plant = Plant(nickName: nickname, h2oFrequency: self.dateFromDatePicker, imageUrl: urlString, species: species)
                self.plantController.sendPlantToServer(plant: plant)
                do {
                    try CoreDataStack.shared.mainContext.save()
                    self.tabBarController?.selectedIndex = 0
                    self.h20FrequencyTextField.text = ""
                    self.speciesTextField.text = ""
                    self.nicknameTextField.text = ""
                    self.imageView.image = nil
                    
                } catch {
                    NSLog("Error saving managed object context with error: \(error)")
                }
            case .failure(let error):
                print(error)
            }
        }
        localNotifHelper.requestAuthorizationStatus { success in
            if success == true {
                self.localNotifHelper.scheduleDailyReminderNotification(name: nickname, times: Date(), calendar: Calendar.current)
            }
        }
    }
    
    @IBAction func signOut(_ sender: Any) {
        AuthServices.shared.signOut { (success) in
            if success {
                self.navigationController?.popToRootViewController(animated: true)
            }
        }
    }
    
    // Added Code for image picker
    @objc func presentPicker() {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        picker.delegate = self
        self.present(picker, animated: true, completion: nil)
    }
    
}

extension AddPlantViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let imageSelected = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            imageView.image = imageSelected
        }
        if let imageOriginal = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageView.image = imageOriginal
        }
        picker.dismiss(animated: true, completion: nil)
    }
}




