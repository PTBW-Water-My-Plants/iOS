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
    @IBOutlet weak var sameraButton: UIButton!
    
    private var countDownTime: UIDatePicker?
    var imagePicker = UIImagePickerController()
    
    
    
    
    // MARK: - View Loading
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDatePicker()
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
    
    private func convertImageToBase64String () -> String {
        
        guard let image = imageView.image else { return "" }
        return image.jpegData(compressionQuality: 1)?.base64EncodedString() ?? ""
        
     }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        //Saving data to server
        guard let nickname = nicknameTextField.text, !nickname.isEmpty,
            let date = h20FrequencyTextField.text,
            let species = speciesTextField.text else { return }
        
        let formatterToString = DateFormatter()
        formatterToString.timeZone = .current
        formatterToString.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        
        let formatterToDateFromString = DateFormatter()
        formatterToDateFromString.timeZone = .current
        
 
       
       //   Msg_Date_ =  dateFormatterPrint.string(from: datee ?? Date())

        //  print(Msg_Date_)
        
        
        
        let timeDate = formatterToDateFromString.date(from: date)
        
//        guard let timeInterval = formatterToDateFromString.date(from: date)?.timeIntervalSince1970 else { return }
       
        // convert to Integer
        let myInt = Int(timeDate?.intVal ?? 1)
        let plant = Plant(nickName: nickname, h2oFrequency: Int16(myInt), imageUrl: convertImageToBase64String(), species: species)
        
        plantController.sendPlantToServer(plant: plant)
        
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


extension AddPlantViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageView.image = image
        }
        dismiss(animated: true, completion: nil)
    }
    
    
    
}

extension Date{
    var intVal: Int?{
        if let d = Date.coordinate{
             let inteval = Date().timeIntervalSince(d)
             return Int(inteval)
        }
        return nil
    }

    // today's time is close to `2020-04-17 05:06:06`

    static let coordinate: Date? = {
        let dateFormatCoordinate = DateFormatter()
        dateFormatCoordinate.dateFormat = "yyyy-MM-dd HH:mm:ss"
        if let d = dateFormatCoordinate.date(from: "2020-04-17 05:06:06") {
            return d
        }
        return nil
    }()
}


extension Int{
    var dateVal: Date?{
        // convert Int to Double
        let interval = Double(self)
        if let d = Date.coordinate{
            return  Date(timeInterval: interval, since: d)
        }
        return nil
    }
}

