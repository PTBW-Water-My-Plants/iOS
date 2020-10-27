//
//  Plant+Convenience.swift
//  Water My Plants
//
//  Created by Sammy Alvarado on 10/17/20.
//

import Foundation
import CoreData

extension Plant {
    
    var plantRepresentation: PlantRepresentation? {
        
        guard let  id = id,
        let nickName = nickName,
        let species = species else { return nil }
        
        return PlantRepresentation(id: id.uuidString ,
                                   h2oFrequency: h2oFrequency ?? Date(),
                                   imageUrl: imageUrl,
                                   nickName: nickName ,
                                   species: species )
    }
    
    @discardableResult convenience init(id: UUID = UUID(),
                                        nickName: String,
                                        h2oFrequency: Date,
                                        imageUrl: String? = nil,
                                        species: String,
                                        context: NSManagedObjectContext = CoreDataStack.shared.mainContext
    ) {
        self.init(context: context)
        self.id = id
        self.h2oFrequency = h2oFrequency
        self.imageUrl = imageUrl
        self.species = species
        self.nickName = nickName
    }
    
    @discardableResult convenience init?(plantRepresentation: PlantRepresentation, context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {

        guard let id = UUID(uuidString: plantRepresentation.id) else { return nil }
        
        self.init(id: id,
                  nickName: plantRepresentation.nickName,
                  h2oFrequency: plantRepresentation.h2oFrequency,
                  imageUrl: plantRepresentation.imageUrl,
                  species: plantRepresentation.species,
                  context: context)
    }
}
