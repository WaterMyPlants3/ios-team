//
//  Plant+Convenience.swift
//  WaterMyPlants
//
//  Created by Patrick Millet on 2/1/20.
//  Copyright © 2020 WaterMyPlants3. All rights reserved.
//

import Foundation
import CoreData
/*struct PlantRepresentation: Codable {
var h2oFrequency: Int64?
var imageName: String?
var nickname: String?
var identifier: String? */

 extension Plant: Persistable {
    // Need initalizers to handle representation and local inits
    
    @discardableResult convenience init(h2oFrequeny: Int64, imageName: String, nickname: String, identifier: String, context: NSManagedObjectContext = CoreDataStack
    
 }
