//
//  AddPlantViewController.swift
//  WaterMyPlants
//
//  Created by Lambda_School_Loaner_218 on 2/3/20.
//  Copyright © 2020 WaterMyPlants3. All rights reserved.
//

import UIKit

class AddPlantViewController: UIViewController {
    
    //Outlets
    @IBOutlet weak var plantNameTextField: UITextField!
    @IBOutlet weak var waterPerDayTextField: UITextField!
    @IBOutlet weak var SpeciesTextField: UITextField!
    @IBOutlet weak var plantImageView: UIImageView!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var plantArray = [PlantRepresentation]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func SaveButtonTapped(_ sender: UIBarButtonItem) {
        
        guard let plantName = plantNameTextField.text,
            let waterPerDay = waterPerDayTextField.text,
            let species = SpeciesTextField.text,
            let plantImage = plantImageView.image,
            let date = datePicker.self else { return }
        
        if !plantName.isEmpty, !waterPerDay.isEmpty, !species.isEmpty {
            plantArray.append(<#T##newElement: PlantRepresentation##PlantRepresentation#>)
        }
            
        
    }
    
    
    
    
    
}
