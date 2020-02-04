//
//  PlantsTableViewCell.swift
//  WaterMyPlants
//
//  Created by Lambda_School_Loaner_218 on 2/3/20.
//  Copyright © 2020 WaterMyPlants3. All rights reserved.
//

import UIKit

class PlantsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var plantName: UILabel!
    @IBOutlet weak var speciesName: UILabel!
    @IBOutlet weak var plantImage: UIImageView!
    
    var plant: Plant? {
        didSet {
            updateViews()
        }
    }
    
    private func updateViews() {
        guard let plant = plant else { return }
        
        plantName.text = plant.nickname
        speciesName.text = plant.species
        plantImage.image = UIImage(cgImage: plantImage as! CGImage)
        
        
        
    }
    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }

}
