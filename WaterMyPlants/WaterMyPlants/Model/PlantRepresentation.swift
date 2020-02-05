//
//  PlantRepresentation.swift
//  WaterMyPlants
//
//  Created by Patrick Millet on 2/1/20.
//  Copyright © 2020 WaterMyPlants3. All rights reserved.
//

import Foundation
import CoreData
import UIKit


struct PlantRepresentation: Equatable, Codable {
    var nickname: String
    var plantKey: Int?
    var species: String?
    var h2oFrequency: Int64
}


struct PlantRepresentations: Codable {
    let results: [PlantRepresentation]
}
