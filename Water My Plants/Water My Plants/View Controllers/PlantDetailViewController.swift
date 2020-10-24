//
//  PlantDetailViewController.swift
//  Water My Plants
//
//  Created by Bohdan Tkachenko on 10/20/20.
//

import UIKit

class PlantDetailViewController: UIViewController {
    
    @IBOutlet weak var plantImageView: UIImageView!
    @IBOutlet weak var nickNameTextField: UITextField!
    
    @IBOutlet weak var speciesTextField: UITextField!
    @IBOutlet weak var h2oFrequencyTextField: UITextField!
    
    
    var plantController: WaterMyPlantController?
    var plant: Plant? {
        didSet {
            updateViews()
        }
    }
    
    func updateViews() {
        guard isViewLoaded else { return }
        
        title = plant?.nickName
        nickNameTextField.text = plant?.nickName
        speciesTextField.text = plant?.species
        
        if plant != nil {
            
        } else {
            
        }
    }
    
    
    

    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        navigationItem.rightBarButtonItem = editButtonItem
        // Do any additional setup after loading the view.
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
