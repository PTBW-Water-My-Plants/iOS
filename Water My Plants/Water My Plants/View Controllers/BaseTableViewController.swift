//
//  BaseTableViewController.swift
//  Water My Plants
//
//  Created by Bohdan Tkachenko on 10/19/20.
//

import UIKit

class BaseTableViewController: UITableViewController {
    
    let plantController = PlantController()

    override func viewDidLoad() {
        super.viewDidLoad()
            tableView.register(PlantCell.self, forCellReuseIdentifier: "PlantCell")

    }
    
 
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return MockData.plants.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PlantCell", for: indexPath) as? PlantCell else { fatalError("Can't dequeue cell of type \(PlantTableViewCell.reuseIdentifier)") }
        let currentPlant = MockData.plants[indexPath.row]
        cell.plantMock = currentPlant
        
        //MOCK DATA
//        let urlData = URL(string: MockData.plantMock.imageUrl!)
//        let data = try? Data(contentsOf: urlData!)
        
        //cell.plantMock
        
//        cell.plantName.text = MockData.plantMock.nickName
//        cell.h2oFrequency.text = String(MockData.plantMock.h2oFrequency)
//        cell.plantImageView.image = UIImage(data: data!)?.circleMask
        

        return cell
    }

}
