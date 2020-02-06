//
//  H2OFrequencyViewController.swift
//  WaterMyPlants
//
//  Created by Patrick Millet on 2/6/20.
//  Copyright © 2020 WaterMyPlants3. All rights reserved.
//

import UIKit
import SwiftChart

class H2OFrequencyViewController: UIViewController {

    
    @IBOutlet weak var wateringChart: Chart!
    
    var plantController: PlantController?
    var indexPath: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()        
        NotificationCenter.default.addObserver(
        self,
        selector: #selector(dataDidUpdate),
        name: .dataDidUpdate,
        object: nil)
    }
    

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        NotificationCenter.default.post(name: .dataDidUpdate, object: nil)
    }

    @objc func dataDidUpdate() {
        wateringChart.removeAllSeries()
        
        var data = [Double]()
        
        if let plants = plantController?.plants {
            data = plants.map { Double($0.h2oFrequency) }.reversed()
        }
        wateringChart.add(ChartSeries(data))
        wateringChart.series[0].area = true
    }
}
