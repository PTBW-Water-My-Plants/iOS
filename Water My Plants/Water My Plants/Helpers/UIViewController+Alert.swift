//
//  UIViewController+Alert.swift
//  Water My Plants
//
//  Created by Sammy Alvarado on 10/24/20.
//

import UIKit

extension UIViewController {
    func presentUserInfoAlert(title: String?, message: String?, dismissActionCompletion: ((UIAlertAction) -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "Dismiss", style: .cancel, handler: dismissActionCompletion)
        
        alertController.addAction(dismissAction)
        
        present(alertController, animated: true)
    }
}
