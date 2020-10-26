//
//  OpeingViewController.swift
//  Water My Plants
//
//  Created by Sammy Alvarado on 10/19/20.
//

import UIKit
import FirebaseAuth

class OpeingViewController: UIViewController {
    
    var handle: AuthStateDidChangeListenerHandle?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        navigationController?.setNavigationBarHidden(true, animated: false)
//        
//        self.navigationController?.isNavigationBarHidden = true
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        Auth.auth().removeStateDidChangeListener(handle!)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
        
        handle = Auth.auth().addStateDidChangeListener({ (auth, user) in
        })
        if Auth.auth().currentUser != nil {
            let storyboard = UIStoryboard(name: "HomeView", bundle: Bundle.main)
            guard
                let tabBar = storyboard.instantiateViewController(identifier: "TabBarController") as? UITabBarController
            else { return }
            navigationController?.pushViewController(tabBar, animated: true)
        }
    }
    
    @IBAction func unwind( _ seg: UIStoryboardSegue) {
        AuthServices.shared.signOut { (success) in
            if success {
                self.navigationController?.popToRootViewController(animated: true)
            }
        }
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
