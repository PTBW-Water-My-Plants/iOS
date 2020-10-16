//
//  CoreData.swift
//  Water My Plants
//
//  Created by Sammy Alvarado on 10/16/20.
//

import Foundation
import CoreData

class CoreDataStack {
    static let shared = CoreDataStack()

    lazy var container: NSPersistentContainer =  {
        let container = NSPersistentContainer(name: "CoreDataModel")
        container.loadPersistentStores { (_, error) in
            if let error = error {
                fatalError("Failed to load persistent Stores: \(error)")
            }
        }
        // changed from the parent
        container.viewContext.automaticallyMergesChangesFromParent = true
        return container
    }()

    // added new lin
    func save(context: NSManagedObjectContext = CoreDataStack.shared.mainContext) throws {
        var error: Error?
        context.performAndWait {
            do {
                try context.save()
            } catch let saveError {
                error = saveError

            }
        }
        if let error = error { throw error }
    }

    var mainContext: NSManagedObjectContext {
        return container.viewContext
    }

}
