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
        guard let identifierString = plantRepresentation.identifier,
            let identifier = UUID(uuidString: identifierString),
        let h2oFrequency = plantRepresentation.h2oFrequency,
        let imageName = plantRepresentation.imageName,
        let nickname = plantRepresentation.nickname else {return nil}
        
        self.init(h2oFrequency: Int(h2oFrequency), imageName: imageName, nickname: nickname, identifier: identifier, context: context)
    }
    
    var plantRepresentation: PlantRepresentation {
        
        return PlantRepresentation(h2oFrequency: h2oFrequency, imageName: imageName, nickname: nickname, identifier: identifier?.uuidString ?? "")
    }
    
 }

/*
 
 server -> 4
 
 plantH20Frequency {
 (server#) Date().TimeintervalFromnow() / (server#) -> points in a 24 hour period -> In case of 4... Every 6 hours send notification
 
 Notification @12:00 and 6:00 -> 2 -> (twice a day) -> 2 (coreData comparison) check if there are Dates already associated with a plant, in that case ignore 12 12 -> return what's stored
 }
 */
