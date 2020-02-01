//
//  User.swift
//  WaterMyPlants
//
//  Created by Patrick Millet on 2/1/20.
//  Copyright © 2020 WaterMyPlants3. All rights reserved.
//

import Foundation

struct User: Codable, Hashable {
    var username: String
    var password: String
    var phoneNumber: String
}
