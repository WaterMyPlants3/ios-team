//
//  Plant+Convenience.swift
//  WaterMyPlants
//
//  Created by Patrick Millet on 2/1/20.
//  Copyright © 2020 WaterMyPlants3. All rights reserved.
//

import Foundation
import CoreData


 var persistentStoreController: PersistentStoreController = CoreDataStack()
let context = persistentStoreController.mainContext

 extension Plant: Persistable, PersistentStoreControllerDelegate {
    
    var plantRepresentation: PlantRepresentation? {
        guard let nickname = nickname,
        let species = species else { return nil }
        
        return PlantRepresentation(nickname: nickname, species: species, h2oFrequency: h2oFrequency)
        
    }
    // Need initalizers to handle representation and local inits
    @discardableResult convenience init?(h2oFrequency: Int, imageName: String, nickname: String, identifier: UUID = UUID(), context: PersistentContext) {
        
        guard let context = context as? NSManagedObjectContext else { return nil }
        
        self.init(context: context)
        
        self.h2oFrequency = Int64(h2oFrequency)
        self.nickname = nickname
    }
    
    @discardableResult convenience init?(plantRepresentation: PlantRepresentation, context: PersistentContext) {
        guard let plantKey = plantRepresentation.plantKey else { return nil }
        
        let h2oFrequency = plantRepresentation.h2oFrequency
        let nickname = plantRepresentation.nickname
        let species = plantRepresentation.species
        
        self.init(h2oFrequency: Int(h2oFrequency), nickname: nickname, plantKey: plantKey, context: context)
    }
    
   
    
 }
