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
    @IBOutlet weak var SpeciesTextField: UITextField!
    @IBOutlet weak var waterFerquencySelector: UISegmentedControl!
    
    
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
        let waterFre: WaterFrequency
        if let waterFerquency = plant?.h2oFrequency {
            waterFre = WaterFrequency(rawValue: waterFerquency) ?? .once
        }
        
        
        
    }
    
    
    @IBAction func SaveButtonTapped(_ sender: UIBarButtonItem) {
        guard let name = plantNameTextField.text, let species = SpeciesTextField.text else { return }
        let waterIndex = waterFerquencySelector.selectedSegmentIndex
        let watering = WaterFrequency.allCase[waterIndex]
        if let plant = plant {
            plantController.createPlant(with: name, species: species, h2oFrequency: watering.rawValue)
            navigationController?.popViewController(animated: true)
        }
        }
    }
    

