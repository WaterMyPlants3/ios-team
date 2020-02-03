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
    var plantImage: UIImage {
         UIImage(named: imageName)!
    }
    var h2oFrequency: Int
    var h2oDate: Date {
        let dateformatter = DateFormatter()
        dateformatter.
        let newDate = Date().timeIntervalSinceNow
        let dividend = h2oFrequency
        let intDate = Int(newDate)
        intDate / h2oFrequency
    }
    var species: String
}

struct PlantRepresentations: Codable {
    let results: [PlantRepresentation]
}
