//
//  NetworkErrors.swift
//  WaterMyPlants
//
//  Created by Patrick Millet on 2/3/20.
//  Copyright © 2020 WaterMyPlants3. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case badAuth
    case noAuth
    case otherError
    case badData
    case noDecode
}
