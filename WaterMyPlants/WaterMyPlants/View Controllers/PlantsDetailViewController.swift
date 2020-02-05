//
//  PlantsDetailViewController.swift
//  WaterMyPlants
//
//  Created by Lambda_School_Loaner_218 on 2/3/20.
//  Copyright © 2020 WaterMyPlants3. All rights reserved.
//

import UIKit

class PlantsDetailViewController: UIViewController {

    @IBOutlet weak var plantImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var NickNameLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    var plant: Plant? {
        didSet {
            updateViews()
        }
    }
     
    func updateViews() {
        guard let plant = plant else { return }
        nameLabel.text = plant.species
        NickNameLabel.text = plant.nickname
    }
    
    
}
