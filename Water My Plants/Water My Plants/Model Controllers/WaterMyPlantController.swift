//
//  WaterMyPlantController.swift
//  Water My Plants
//
//  Created by Bohdan Tkachenko on 10/20/20.
//

import Foundation
import CoreData




class WaterMyPlantController {
    
    var plants: [PlantRepresentation] = []
    var plant: PlantRepresentation?
    let userController = UserController()
    public var completion: ((String, String, Date) -> Void)?
    let baseURL = URL(string: "https://water-my-plants-73fe4.firebaseio.com/")!
    
    //let baseURL = URL(string: "https://water-my-plant-1b44a.firebaseio.com/")!
    typealias CompletionHandler = (Result<Bool, NetworkError>) -> Void
    
    
    init() {
        fetchPlantFromServer()
    }
    
    
    
    // MARK: - CRUD
    func createPlant(with nickname: String, species: String, h20Frequency: Int16, image: String?) {
        let plant = PlantRepresentation(id: UUID().uuidString, h2oFrequency: h20Frequency, imageUrl: nil, nickName: nickname, species: species)
        plants.append(plant)
        saveToPersistence()
        
    }
    
    func fetchPlantFromServer(completion: @escaping CompletionHandler = { _ in }) {
        let requestURL = baseURL.appendingPathExtension("json")
        
        URLSession.shared.dataTask(with: requestURL) { data, _, error in
            if let error = error {
                NSLog("Error fetching plants with: \(error)")
                completion(.failure(.otherError))
                return
            }
            
            guard let data = data else {
                NSLog("No data returned from Firebase (Fetching plants)")
                completion(.failure(.noData))
                return
            }
            
            do {
                let plantRepresentation = Array(try JSONDecoder().decode([String: PlantRepresentation].self, from: data).values)
                print(plantRepresentation)
                try self.updatePlant(with: plantRepresentation)
            } catch {
                NSLog("Error decoding plants from Firebase: \(error)")
                completion(.failure(.noDecode))
            }
        }.resume()
    }
    
    
    func updatePlant(with plant: PlantRepresentation, nickname: String, species: String, h2oFrequency: Int16) {
        guard let index = plants.firstIndex(of: plant) else { return }
        var scratch = plants[index]
        scratch.nickName = nickname
        scratch.species = species
        scratch.h2oFrequency = h2oFrequency
    }
    
    func sendPlantToServer(plant: Plant, completion: @escaping CompletionHandler = { _ in }) {
        //print(auth.bearer)
        guard let uuid = plant.id else {
            completion(.failure(.noId))
            return
        }
        
        let requestURL = baseURL.appendingPathComponent(uuid.uuidString).appendingPathExtension("json")
        var request = URLRequest(url: requestURL)
        request.httpMethod = "PUT"
        
        do {
            guard let represenation  = plant.plantRepresentation else {
                completion(.failure(.noEncode))
                return
            }
            request.httpBody = try JSONEncoder().encode(represenation)
        } catch {
            NSLog("Error encoding plant: \(plant), \(error)")
            completion(.failure(.noEncode))
            return
        }
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error sending plant to server \(plant), \(error)")
                completion(.failure(.otherError))
                return
            }
            completion(.success(true))
        }.resume()
    }
    
    
    
    private func updatePlant (with representations: [PlantRepresentation]) throws {
        let identifiersToFetch = representations.compactMap { UUID(uuidString: $0.id) }
        let representationByID = Dictionary(uniqueKeysWithValues: zip(identifiersToFetch, representations))
        var plantCreate = representationByID
        
        let fetchRequest: NSFetchRequest<Plant> = Plant.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id IN %@", identifiersToFetch)
        
        let context = CoreDataStack.shared.mainContext
        
        let existingPlants = try context.fetch(fetchRequest)
        //Existing Plant
        for plant in existingPlants {
            guard let id = plant.id,
                  let representation = representationByID[id] else { continue }
            self.update(plant: plant, with: representation)
            plantCreate.removeValue(forKey: id)
        }
        
        //New Plant
        for representation in plantCreate.values {
            Plant(plantRepresentation: representation, context: context)
        }
        
        try context.save()
        
    }
    
    
    private func update(plant: Plant, with representation: PlantRepresentation) {
        plant.nickName = representation.nickName
        plant.species = representation.species
        plant.h2oFrequency = representation.h2oFrequency
    }
    func deletePlantFromServer(_ plant: Plant, completion: @escaping CompletionHandler = { _ in }) {
        guard let uuid = plant.id else {
            completion(.failure(.noId))
            return
        }
        
        let requestURL = baseURL.appendingPathComponent(uuid.uuidString).appendingPathExtension("json")
        var request = URLRequest(url: requestURL)
        request.httpMethod = "DELETE"
        
        URLSession.shared.dataTask(with: request) { (_, _, error) in
            if let error = error {
                NSLog("Error deleting plant from server \(plant), \(error)")
                completion(.failure(.otherError))
                return
            }
            completion(.success(true))
        }.resume()
    }
    
}


