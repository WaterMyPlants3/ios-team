//
//  PlantsTableViewCell.swift
//  WaterMyPlants
//
//  Created by Lambda_School_Loaner_218 on 2/6/20.
//  Copyright © 2020 WaterMyPlants3. All rights reserved.
//

import UIKit

class PlantsTableViewCell: UITableViewCell {

    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var speciesLabel: UILabel!
    @IBOutlet weak var h2oLabel: UILabel!
    
    
    var plant: Plant? {
        didSet {
            updateViews()
        }
    }
    
    func updateViews() {
        guard let plant = plant else { return }
        nickNameLabel.text = plant.nickname
        speciesLabel.text = plant.species
        h2oLabel.text = "water me every \(plant.h2oFrequency) day(s)" 
    }


}
