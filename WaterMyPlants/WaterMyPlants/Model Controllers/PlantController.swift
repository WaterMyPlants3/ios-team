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
    
     typealias CompletionHandler = (Error?) -> Void
    
    static let sharedInstance = PlantController()
    
    private let firebaseURL = URL(string: "")!
    private let databaseURL = URL(string: "")!
    
    
    
    func put(plant: Plant, completion: @escaping CompletionHandler = { _ in }) {
        // Told it what endpoint or URL to send it to and constructed the URL
        let identifier = plant.identifier ?? UUID()
        let requestURL = databaseURL.appendingPathComponent(identifier.uuidString).appendingPathExtension("json")
        var request = URLRequest(url: requestURL)
        request.httpMethod = "PUT"
        
        do {
            request.httpBody = try JSONEncoder().encode(plant.plantRepresentation)
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
    
    func updatePlant(with representation: [PlantRepresentation]) {
        
    }

    private func update(plant: Plant, with representation: PlantRepresentation) {
        plant.nickname = representation.nickname
        plant.imageName = representation.imageName
        plant.identifier = representation.identifier
        plant.h2oFrequency = representation.h2oFrequency
        plant.species = representation.species
        
    }
}
