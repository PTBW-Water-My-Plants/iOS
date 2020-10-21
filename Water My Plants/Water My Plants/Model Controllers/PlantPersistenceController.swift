//
//  PlantPersistenceController.swift
//  Water My Plants
//
//  Created by Bohdan Tkachenko on 10/20/20.
//

import Foundation

extension WaterMyPlantController {
    
    // MARK: - Properties
    var plantURL: URL? {
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        let fileName = "Plant List.plist"
        return documentsDirectory.appendingPathComponent(fileName)
    }
    
    // MARK: - Persistence Methods
    func saveToPersistence() {
        let plistEncoder = PropertyListEncoder()
        do {
            guard let plant = plantURL else { return }
            let encodedPlant = try plistEncoder.encode(plants)
            try encodedPlant.write(to: plant)
        } catch let error {
            print("Error trying to save data: \(error)")
        }
    }
    
    func loadFromPersistence() {
        do {
            guard let plant = plantURL else { return }
            let encodedPlant = try Data(contentsOf: plant)
            let plistDecoder = PropertyListDecoder()
            let decodedPlant = try plistDecoder.decode([PlantRepresentation].self, from: encodedPlant)
            self.plants = decodedPlant
            
        } catch let error {
            print("Error trying to load data: \(error)")
        }
    }
}
