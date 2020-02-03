//
//  PlantController.swift
//  WaterMyPlants
//
//  Created by Patrick Millet on 2/1/20.
//  Copyright © 2020 WaterMyPlants3. All rights reserved.
//

import Foundation
import CoreData

class PlantController {
    
    
    // MARK: - Properties
    
    var searchedPlants: [PlantRepresentation] = []
    
    static let sharedInstance = PlantController()
    
    private let firebaseURL = URL(string: "")!
    private let databaseURL = URL(string: "")!
    
    
    func fetchPlantsFromServer(completion: @escaping (Error?) -> Void = { _ in }) {
        
        let requestURL = firebaseURL.appendingPathExtension("json")

        var request = URLRequest(url: requestURL)
        request.httpMethod = "GET"

        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                print("Error fetching plants: \(error)")
                DispatchQueue.main.async {
                completion(error)
                }
                return
            }

            guard let data = data else {
                print("No data returned in fetch")
                DispatchQueue.main.async {
                completion(NSError())
                }
                return
            }
            
            do {
                let plantRepresentations = Array(try JSONDecoder().decode([String: PlantRepresentation].self, from: data).values)
                try self.updatePlant(with: plantRepresentations)
                DispatchQueue.main.async {
                completion(nil)
                }
            } catch {
                print("Error decoding plant representation: \(error)")
                completion(error)
                return
            }
        }.resume()
    }
    
    func updatePlant(with representation: [PlantRepresentation]) throws {
        let entriesWithId = representation.filter { $0.identifier != nil }
        let identifiersToFetch = entriesWithId.compactMap { $0.identifier! }
        let representationByID = Dictionary(uniqueKeysWithValues: zip(identifiersToFetch, entriesWithId))

        var entriesToCreate = representationByID

        let fetchRequest: NSFetchRequest<Plant> = Plant.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "identifier IN %@", identifiersToFetch)

        let context = CoreDataStack.shared.container.newBackgroundContext()
        context.perform {
            do {
                let existingPlants = try context.fetch(fetchRequest)

                for plant in existingPlants {
                    guard let id = plant.identifier,
                        let representation = representationByID[id] else { continue }

                    self.update(plant: plant, with: representation)
                    entriesToCreate.removeValue(forKey: id)
                }

                for representation in entriesToCreate.values {
                    Plant(
                }
            } catch {
                print("Error fetching entries for UUIDs: \(error)")
            }
        }

        try CoreDataStack.shared.save(in: context)
    }

    private func update(plant: Plant, with representation: PlantRepresentation) {
        plant.nickname = representation.nickname
        plant.imageName = representation.imageName
        plant.identifier = representation.identifier
        plant.h2oFrequency = representation.h2oFrequency
        plant.species = representation.species
        
    }
}
