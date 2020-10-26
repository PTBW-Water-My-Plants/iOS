//
//  PlantDetailViewController.swift
//  Water My Plants
//
//  Created by Bohdan Tkachenko on 10/20/20.
//

import UIKit

class PlantDetailViewController: UIViewController {
    
    @IBOutlet weak var plantImageView: UIImageView!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var speciesLabel: UILabel!
    @IBOutlet weak var h2oLabel: UILabel!
    @IBOutlet weak var timeLeftLabel: UILabel!
    
    
    
    var plantController: WaterMyPlantController?
    var plant: Plant? {
        didSet {
            updateViews()
        }
    }
    
//    @IBAction func updatePlantButton(_ sender: UIButton) {
//        let context = CoreDataStack.shared.mainContext
//        let existingTodos = try context.fetch(fetchRequest)
//        for plant in existingTodos {
//            guard let id = plant.id,
//                  let representation = representationByID[id] else { continue }
//            self.update(plant: plant, with: representation)
//            plantCreate.removeValue(forKey: id)
//        }
//    }
    
    func updateViews() {
        guard isViewLoaded else { return }
        
        title = plant?.nickName
        nickNameLabel.text = plant?.nickName
        speciesLabel.text = plant?.species
        h2oLabel.text = plant?.imageUrl
        
        
        
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
