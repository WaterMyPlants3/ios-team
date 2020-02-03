//
//  PlantRepresentation.swift
//  WaterMyPlants
//
//  Created by Patrick Millet on 2/1/20.
//  Copyright © 2020 WaterMyPlants3. All rights reserved.
//

import Foundation
import CoreData

struct PlantRepresentation: Codable {
    var h2oFrequency: Int64?
    var imageName: String?
    var nickname: String?
    var identifier: String?
    
}

// Need a plant object here to convert images to data ...... imageName computed property to grab image name from the store.
