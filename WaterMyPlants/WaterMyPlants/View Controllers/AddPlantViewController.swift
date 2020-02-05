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
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var plantArray = [PlantRepresentation]()
    var plantController = PlantController()
    var plant: Plant? {
        didSet {
            updateViews()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    
    func updateViews() {
        title = plant?.nickname ?? "Plant Name"
        plantNameTextField.text = plant?.nickname
        SpeciesTextField.text = plant?.species
        let waterInt = waterPerDayTextField.text
        let intiger = (waterInt as! NSString).integerValue
        let int64 = Int64(intiger)
        
    }
    
    
    @IBAction func SaveButtonTapped(_ sender: UIBarButtonItem) {
        
        guard let plantName = plantNameTextField.text,
            let waterPerDay = waterPerDayTextField.text,
            let species = SpeciesTextField.text,
            let date = datePicker.self else { return }
        
        let intiger = (waterPerDay as NSString).integerValue
        let int64 = Int64(intiger)
        
        if !plantName.isEmpty, !waterPerDay.isEmpty, !species.isEmpty {
            plantController.createPlant(with: plantName, species: species, h2oFrequency: int64)
        }
            
        
    }
    
    
    
    
    
}
