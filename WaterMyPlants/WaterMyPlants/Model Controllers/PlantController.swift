//
//  PlantController.swift
//  WaterMyPlants
//
//  Created by Patrick Millet on 2/1/20.
//  Copyright © 2020 WaterMyPlants3. All rights reserved.
//
import UIKit
import Foundation
import CoreData

class PlantController {
    
    
    // MARK: - Properties
    
    var searchedPlants: [PlantRepresentation] = []
    var persistentStoreController: PersistentStoreController = CoreDataStack()
    var plantCount: Int {
        persistentStoreController.itemCount
    }
    var plants: [PlantRepresentation]? {
        persistentStoreController.allItems as? [PlantRepresentation]
    }
    
    var delegate: PersistentStoreControllerDelegate? {
        get {
            return persistentStoreController.delegate
        }
        set(newDelegate) {
            persistentStoreController.delegate = newDelegate
        }
    }
    
     typealias CompletionHandler = (Error?) -> Void
    
    static let sharedInstance = PlantController()
    
    private let databaseURL = URL(string: "https://water-my-plant-9000.herokuapp.com/")!
    
    
    
    func put(plant: Plant, completion: @escaping CompletionHandler = { _ in }) {
        guard let userID = UserController.sharedInstance.userID else { return }
        let requestURL = databaseURL.appendingPathComponent("api/users/\(userID)/plants")
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.post.rawValue
        
        do {
            request.httpBody = try JSONEncoder().encode(plant.plantRepresentation)
            let putString = String.init(data: request.httpBody!, encoding: .utf8)
            print(putString!)
        } catch {
            NSLog("Error encoding Entry: \(error)")
            completion(error)
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                print("Error fetching entries: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    completion(error)
                }
                return
            }
        }.resume()
    }
    
    
    func fetchPlantsFromServer(completion: @escaping (Error?) -> Void = { _ in }) {
        guard let bearer = UserController.sharedInstance.bearer else { return }
        print(bearer)
        guard let userID = UserController.sharedInstance.userID else { return }
        
        let requestURL = databaseURL.appendingPathExtension("api/users/\(userID)/plants")

        var request = URLRequest(url: requestURL)
        request.httpMethod = "GET"
        request.addValue("Bearer \(bearer.token)", forHTTPHeaderField: "Authorization")
        

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
    
    private func updatePlant(with representation: [PlantRepresentation]) throws {
        let entriesWithId = representation.filter { $0.plantKey != nil }
            let identifiersToFetch = entriesWithId.compactMap { $0.plantKey! }
            let representationByID = Dictionary(uniqueKeysWithValues: zip(identifiersToFetch, entriesWithId))

            var entriesToCreate = representationByID

            let fetchRequest: NSFetchRequest<Plant> = Plant.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "plantKey IN %@", identifiersToFetch)

            let context = CoreDataStack.shared.container.newBackgroundContext()
            context.perform {
                do {
                    let existingPlants = try context.fetch(fetchRequest)

                    for plant in existingPlants {
                         let id = plant.plantKey
                        guard let representation = representationByID[id] else { continue }

                        self.update(plant: plant, with: representation)
                        entriesToCreate.removeValue(forKey: id)
                    }

                    for representation in entriesToCreate.values {
                        Plant(plantRepresentation: representation, context: context)
                    }
                } catch {
                    print("Error fetching entries for UUIDs: \(error)")
                }
            }
        try CoreDataStack.shared.save(in: context)
        }
    
     func deletePlantFromServer(_ plant: Plant, completion: @escaping CompletionHandler = { _ in}) {
        
        
    }

    private func update(plant: Plant, with representation: PlantRepresentation) {
        plant.nickname = representation.nickname
        plant.h2oFrequency = representation.h2oFrequency
        plant.species = representation.species
        plant.plantKey = representation.plantKey ?? 0
    }
    

    func createPlant(with name: String, species: String, h2oFrequency: Int64) throws {
        guard  let plant = Plant(h2oFrequency: Int(h2oFrequency), nickname: name, species: species, context: context) else { return }
        put(plant: plant)
        do {
        try CoreDataStack.shared.save(in: context)
        } catch {
            print("Error saving plant object \(error)")
        }
    }
    
    func delete(for plant: Plant, context: PersistentContext) {
        deletePlantFromServer(plant)
        do {
           try CoreDataStack.shared.delete(plant, in: context)
            try CoreDataStack.shared.save(in: context)
        } catch {
            context.reset()
            print("Error deleting plant from MOC \(error)")
        }
    }
    
    func getPlant(at indexPath: IndexPath) -> Plant? {
        return persistentStoreController.fetchItem(at: indexPath) as? Plant
    }
    
    func deletePlant(at indexPath: IndexPath) throws {
        guard let thisPlant = getPlant(at: indexPath) else { throw NSError() }
        try persistentStoreController.delete(thisPlant, in: nil)
    }
    
    
    }
