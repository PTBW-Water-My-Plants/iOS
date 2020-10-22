//
//  WaterMyPlantController.swift
//  Water My Plants
//
//  Created by Bohdan Tkachenko on 10/20/20.
//

import Foundation

class WaterMyPlantController {
    
    var plants: [PlantRepresentation] = []
    var plant: PlantRepresentation?
    
    init() {
        loadFromPersistence()
    }
    
    // MARK: - CRUD
    func createPlant(with nickname: String, species: String, h20Frequency: Date, image: String?) {
        let plant = PlantRepresentation(id: UUID().uuidString, h2oFrequency: h20Frequency, imageUrl: nil, nickName: nickname, species: species)
        plants.append(plant)
        saveToPersistence()
    }
    
    func updatePlant(with plant: PlantRepresentation, nickname: String, species: String, h2oFrequency: Date) {
        guard let index = plants.firstIndex(of: plant) else { return }
        var scratch = plants[index]
        scratch.nickName = nickname
        scratch.species = species
        scratch.h2oFrequency = h2oFrequency
        
        plants.remove(at: index)
        plants.insert(scratch, at: index)
        saveToPersistence()
    }
    
    func deletePlant(with plant: PlantRepresentation) {
        guard let index = plants.firstIndex(of: plant) else { return }
        plants.remove(at: index)
        saveToPersistence()
    }
    
}
