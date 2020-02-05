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
    
     typealias CompletionHandler = (Error?) -> Void
    
    static let sharedInstance = PlantController()
    
    private let firebaseURL = URL(string: "")!
    private let databaseURL = URL(string: "https://water-my-plant-9000.herokuapp.com/")!
    
    
    
    func put(plant: Plant, completion: @escaping CompletionHandler = { _ in }) {
        // Told it what endpoint or URL to send it to and constructed the URL
        guard let userID = UserController.sharedInstance.userID else { return }
        let requestURL = databaseURL.appendingPathComponent("api/users/\(userID)/plants")
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.post.rawValue
        
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
        plant.h2oFrequency = representation.h2oFrequency
        plant.species = representation.species
        
    }
    
    func createPlant(with name:String, species: String, h2oFrequency: Int64, plantImage: String) {
        let plant = Plant(h2oFrequency: Int(h2oFrequency), imageName: plantImage, nickname: name, context: context)
        
        try? CoreDataStack.shared.save(in: context)

    
    }
}
