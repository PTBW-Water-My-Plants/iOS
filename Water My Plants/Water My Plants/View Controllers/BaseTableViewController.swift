//
//  BaseTableViewController.swift
//  Water My Plants
//
//  Created by Bohdan Tkachenko on 10/15/20.
//

import UIKit

class BaseTableViewController: UITableViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: PlantTableViewCell.reuseIdentifier, for: indexPath) as? PlantTableViewCell else { fatalError("Can't dequeue cell of type \(PlantTableViewCell.reuseIdentifier)") }
    
        

        return cell
    }

}
