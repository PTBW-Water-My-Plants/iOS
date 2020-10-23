//
//  PlantDetailViewController.swift
//  Water My Plants
//
//  Created by Bohdan Tkachenko on 10/20/20.
//

import UIKit

class PlantDetailViewController: UIViewController {
    
    
    
    var plantController: WaterMyPlantController?
    var plant: Plant? {
        didSet {
            
        }
    }
    
    @IBOutlet weak var treeImageView: UIImageView!
    @IBOutlet weak var speciesLabel: UILabel!
    @IBOutlet weak var h2oLabel: UILabel!
    @IBOutlet weak var timeleftLabel: UILabel!
    
    
    

    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
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
