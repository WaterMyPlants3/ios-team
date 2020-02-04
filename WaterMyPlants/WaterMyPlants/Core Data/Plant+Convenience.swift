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
    // Need initalizers to handle representation and local inits
    @discardableResult convenience init?(h2oFrequency: Int, imageName: String, nickname: String, identifier: UUID = UUID(), context: PersistentContext) {
        
        guard let context = context as? NSManagedObjectContext else { return nil }
        
        self.init(context: context)
        
        self.h2oFrequency = Int64(h2oFrequency)
        self.imageName = imageName
        self.nickname = nickname
        self.identifier = identifier
    }
    
    @discardableResult convenience init?(plantRepresentation: PlantRepresentation, context: PersistentContext) {
        guard let identifier = plantRepresentation.identifier else { return nil }
        
        let h2oFrequency = plantRepresentation.h2oFrequency
        let imageName = plantRepresentation.imageName
        let nickname = plantRepresentation.nickname
        
        self.init(h2oFrequency: Int(h2oFrequency), imageName: imageName, nickname: nickname, identifier: identifier, context: context)
    }
 }
