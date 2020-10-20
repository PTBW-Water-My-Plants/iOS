//
//  LocalNotificationHelper.swift
//  Water My Plants
//
//  Created by Bohdan Tkachenko on 10/19/20.
//

import Foundation
import UserNotifications

//MARK: Finish it!
class LocalNotificationHelper: NSObject, UNUserNotificationCenterDelegate {
    
    // MARK: - Properties
   // var plantController
    
    // MARK: - LocalNotificationController Delagate Methods
    
    func getAuthorizationStatus(completion: @escaping (UNAuthorizationStatus) -> Void) {
        UNUserNotificationCenter.current().getNotificationSettings { (settings) in
            DispatchQueue.main.async {
                completion(settings.authorizationStatus)
            }
        }
    }
    
    func requestAuthorizationStatus(completion: @escaping (Bool) -> Void) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (success, error) in
            if let error = error {
                NSLog("Error requesting authorization status for local notifications: \(error)")
            }
            DispatchQueue.main.async {
                completion(success)
            }
        }
    }
    
    func scheduleDailyReminderNotification(name: String, times: Date, calendar: Calendar) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .none
        dateFormatter.timeStyle = .short
        let time = dateFormatter.string(from: times)
        let dateComponents = calendar.dateComponents([.hour, .minute], from: times)
        
        let content = UNMutableNotificationContent()
        content.title = "It's time to water \(name)."
        content.body = "It's \(time)! \(name) is getting thirsty."
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let request = UNNotificationRequest(identifier: "PlantIdentifier", content: content, trigger: trigger)
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        
        center.add(request) { (error) in
            if let error = error {
                print("There was an error scheduling a notification: \(error)")
                return
            }
        }
    }
}
