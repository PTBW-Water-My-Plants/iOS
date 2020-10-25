//
//  BaseTableViewController.swift
//  Water My Plants
//
//  Created by Bohdan Tkachenko on 10/19/20.
//

import UIKit
import CoreData
import UserNotifications
import FirebaseAuth

class BaseTableViewController: UITableViewController {
    
    
    let userController = UserController()
    let plantController = WaterMyPlantController()
    var currentUser: User?
    var isCellSegue: Bool = false
    
    
    
    
    lazy var fetchResultController: NSFetchedResultsController<Plant> = {
        let fetchRequest: NSFetchRequest<Plant> = Plant.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "id", ascending: true),
                                        NSSortDescriptor(key: "nickName", ascending: true)
        ]
        let context = CoreDataStack.shared.mainContext
        let frc = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: "id", cacheName: nil)
        frc.delegate = self
        
        do {
            try frc.performFetch()
        } catch {
            NSLog("Error performing initial fetch inside fetchedresultController wit erro: \(error)")
        }
        return frc
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(PlantCell.self, forCellReuseIdentifier: "PlantCell")
        self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //        if apiController.bearer == nil {
        //            performSegue(withIdentifier: "LoginSegue", sender: self)
        //        } else {
        //            plantController.bearer = apiController.bearer
        //            DispatchQueue.main.async {
        //                self.tableView.reloadData()
        //            }
        //        }
    }
    
    // MARK: - Delegate Method
    func didSaveUser(user: User) {
        currentUser = user
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return fetchResultController.sections?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return fetchResultController.sections?[section].numberOfObjects ?? 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PlantCell", for: indexPath) as? PlantCell else { fatalError("Can't dequeue cell of type \(PlantTableViewCell.reuseIdentifier)") }
        
        cell.delegate = self
        cell.plant = fetchResultController.object(at: indexPath)
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let plant = fetchResultController.object(at: indexPath)
            //Deletion plant from server and coredata
            plantController.deletePlantFromServer(plant) { result in
                guard let _ = try? result.get() else {
                    return
                }
                let context = CoreDataStack.shared.mainContext
                context.delete(plant)
                do {
                    try context.save()
                } catch {
                    context.reset()
                    NSLog("Error saving managed object contect (delete task): \(error)")
                }
            }
        }
    }
    
    @IBAction func signout(_ sender: Any) {
        AuthServices.shared.signOut { (success) in
            if success {
                self.navigationController?.popToRootViewController(animated: true)
            }
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
               if segue.identifier == "CellSegue" {
                    if let detailVC = segue.destination as? PlantDetailViewController,
                        let indexPath = tableView.indexPathForSelectedRow {
                        detailVC.plant = fetchResultController.object(at: indexPath)
                        detailVC.plantController = self.plantController
                        detailVC.title = "Details"
                    }
                }
    }
    
}


//MARK: Extensions
extension BaseTableViewController: NSFetchedResultsControllerDelegate {
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                    didChange sectionInfo: NSFetchedResultsSectionInfo,
                    atSectionIndex sectionIndex: Int,
                    for type: NSFetchedResultsChangeType) {
        switch type {
        case .insert:
            tableView.insertSections(IndexSet(integer: sectionIndex), with: .automatic)
        case .delete:
            tableView.deleteSections(IndexSet(integer: sectionIndex), with: .automatic)
        default:
            break
        }
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                    didChange anObject: Any,
                    at indexPath: IndexPath?,
                    for type: NSFetchedResultsChangeType,
                    newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            guard let newIndexPath = newIndexPath else { return }
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        case .update:
            guard let indexPath = indexPath else { return }
            tableView.reloadRows(at: [indexPath], with: .automatic)
        case .move:
            guard let oldIndexPath = indexPath,
                  let newIndexPath = newIndexPath else { return }
            tableView.deleteRows(at: [oldIndexPath], with: .automatic)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        case .delete:
            guard let indexPath = indexPath else { return }
            tableView.deleteRows(at: [indexPath], with: .automatic)
        @unknown default:
            break
        }
    }
}


extension BaseTableViewController: PlantCellDelegate {
    func didUpdatePlant(plant: Plant) {
        plantController.sendPlantToServer(plant: plant)
    }
}
