//
//  Plant+Convenience.swift
//  WaterMyPlants
//
//  Created by Patrick Millet on 2/1/20.
//  Copyright © 2020 WaterMyPlants3. All rights reserved.
//

import Foundation
import CoreData


enum WaterFrequency: Int64 {
    case once = 1
    case twice = 2
    case three = 3
    
    static var allCase: [WaterFrequency] {
        return [.once, .twice, .three]
    }
}


 var persistentStoreController: PersistentStoreController = CoreDataStack()
let context = persistentStoreController.mainContext

 extension Plant: Persistable, PersistentStoreControllerDelegate {
    
    var plantRepresentation: PlantRepresentation? {
        guard let nickname = nickname,
        let species = species else { return nil }
        
        return PlantRepresentation(nickname: nickname, species: species, h2oFrequency: h2oFrequency)
        
    }
    // Need initalizers to handle representation and local inits
    @discardableResult convenience init?(h2oFrequency: Int64?, nickname: String, species: String, plantKey: Int64?, context: PersistentContext) {
        
        guard let context = context as? NSManagedObjectContext else { return nil }
        guard let h2oFrequency = h2oFrequency,
              let plantKey = plantKey else { return nil }
        self.init(context: context)
        
        self.h2oFrequency = h2oFrequency
        self.nickname = nickname
        self.plantKey = plantKey
    }
    
    @discardableResult convenience init?(h2oFrequency: Int, nickname: String, species: String, context: PersistentContext) {
        
        guard let context = context as? NSManagedObjectContext else {return nil}
        self.init(context: context)
        self.h2oFrequency = Int64(h2oFrequency)
        self.nickname = nickname
        self.species = species
    }
    
    @discardableResult convenience init?(plantRepresentation: PlantRepresentation, context: PersistentContext) {
        guard let plantKey = plantRepresentation.plantKey else { return nil }
        
        let h2oFrequency = plantRepresentation.h2oFrequency
        let nickname = plantRepresentation.nickname
        guard let species = plantRepresentation.species else { return nil }
        
        self.init(h2oFrequency: h2oFrequency, nickname: nickname, species: species, plantKey: Int64(plantKey), context: context)
    }
 }
