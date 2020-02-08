//
//  WaterMyPlantsTests.swift
//  WaterMyPlantsTests
//
//  Created by Lambda_School_Loaner_218 on 2/7/20.
//  Copyright © 2020 WaterMyPlants3. All rights reserved.
//

import XCTest
@testable import WaterMyPlants

class WaterMyPlantsTests: XCTestCase {
    

    func testAddingPlant() {
        var plantController = PlantController()
        try! plantController.createPlant(with: "Tyler", species: "FlyTrap", h2oFrequency: 20)
        
        
        
    }
    
    
    func testdeletePlant() {
        var plantController = PlantController()
       try! plantController.createPlant(with: "Tyler", species: "FlyTrap", h2oFrequency: 20)
       try! plantController.deletePlant(at: IndexPath.init(row: 1, section: 0))
          
        
        
    }

    
 
    
    
}
