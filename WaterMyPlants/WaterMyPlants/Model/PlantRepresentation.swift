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
    var imageName: String
    var identifier: UUID?
    var plantImage: UIImage {
         UIImage(named: imageName)!
    }
    var h2oFrequency: Int64
    var h2oDate: Date {
        let dateformatter = DateFormatter()
        let newDate = Date().timeIntervalSinceNow
        let dividend = h2oFrequency
        let intDate = Int(newDate)
        return Date()
        
        // Need to find a way to take Int from server and convert int into Date object and display notifications at intervals matching the returned Int
    }
    var species: String
}

struct PlantRepresentations: Codable {
    let results: [PlantRepresentation]
}
