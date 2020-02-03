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
    
   
    
    @discardableResult convenience init(h2oFrequency: Int64, imageName: String? = nil, nickname: String? = nil, identifier: UUID = UUID(), context: PersistentContext = context) {
        
        self.h2oFrequency = h2oFrequency
        self.imageName = imageName
        self.nickname = nickname
        self.identifier = identifier
        
        
    }
    
    @discardableResult convenience init?(plantRepresentation: PlantRepresentation, context: PersistentContext = context) {
        guard let identifierString = plantRepresentation.identifier,
            let identifier = UUID(uuidString: identifierString),
        let h2oFrequency = plantRepresentation.h2oFrequency,
        let imageName = plantRepresentation.imageName,
        let nickname = plantRepresentation.nickname else {return nil}
        
        self.init(h2oFrequency: plantRepresentation.h2oFrequency, imageName: plantRepresentation.imageName, nickname: plantRepresentation.nickname, identifier: identifier, context: context)
    }
    
    var plantRepresentation: PlantRepresentation {
        
        return PlantRepresentation(h2oFrequency: h2oFrequency, imageName: imageName, nickname: nickname, identifier: identifier?.uuidString ?? "")
    }
    
 }
