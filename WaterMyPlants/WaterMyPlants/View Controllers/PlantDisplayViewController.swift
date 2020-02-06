//
//  PlantDisplayViewController.swift
//  WaterMyPlants
//
//  Created by Patrick Millet on 2/5/20.
//  Copyright © 2020 WaterMyPlants3. All rights reserved.
//

import UIKit
import SwiftChart

class PlantDisplayViewController: UIViewController {
    //
    @IBOutlet private weak var plantTableView: UITableView!
    @IBOutlet private weak var wateringChart: Chart!
        
        private var plantController = PlantController()
        private var tableDataSource = PlantTableViewDataSource()
        
        // MARK: - Methods
        override func viewDidLoad() {
            super.viewDidLoad()
            
            plantTableView.delegate = self
            plantTableView.dataSource = tableDataSource
            
            tableDataSource.plantTableView = plantTableView
            tableDataSource.plantController = plantController
            
            plantController.delegate = tableDataSource
            plantController.fetchPlantsFromServer()
            
            dataDidUpdate()
            plantTableView.reloadData()
            
            NotificationCenter.default.addObserver(
                self,
                selector: #selector(dataDidUpdate),
                name: .dataDidUpdate,
                object: nil)
        }
    
    override func viewDidAppear(_ animated: Bool) {
        plantController.fetchPlantsFromServer()
        plantTableView.reloadData()
    }
        
        @IBAction func addPlantButtonTapped(_ sender: UIBarButtonItem) {
            let alert = UIAlertController(
                title: "Add a new plant here!",
                message: "Don't forget about me.",
                preferredStyle: .alert)
            alert.addTextField { textField in
                textField.placeholder = "name this plant"
            }
            alert.addTextField { textfield in
                textfield.placeholder = "what species am I?"
            }
            alert.addTextField { textField in
                textField.placeholder = "# days between watering"
            }
            
            alert.addAction(UIAlertAction(
                title: "Cancel",
                style: .cancel,
                handler: nil))
            alert.addAction(UIAlertAction(
                title: "Add record",
                style: .default,
                handler: { [unowned alert] _ in
                    guard let h2oText = alert.textFields?[0].text,
                        let nickname = alert.textFields?[0].text,
                        let species = alert.textFields?[0].text,
                        let h2o = Int64(h2oText)
                        else { return }
                    do {
                        try self.plantController.createPlant(with: nickname, species: species, h2oFrequency: h2o)
                        NotificationCenter.default.post(name: .dataDidUpdate, object: nil)
                    } catch {
                        NSLog("Error saving entry to persistent store: \(error)")
                    }
            }))
            present(alert, animated: true, completion: nil)
        }
        
@objc func dataDidUpdate() {
            wateringChart.removeAllSeries()
            
            var data = [Double]()
            
            if let plants = plantController.plants {
                data = plants.map { Double($0.h2oFrequency) }.reversed()
            }
            wateringChart.add(ChartSeries(data))
            wateringChart.series[0].area = true
            plantTableView.reloadData()
        }
    }

    // MARK: - Table View Delegate

    extension PlantDisplayViewController: UITableViewDelegate {
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
