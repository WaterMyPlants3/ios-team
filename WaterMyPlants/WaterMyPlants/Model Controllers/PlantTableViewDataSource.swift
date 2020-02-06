//
//  PlantTableViewDataSource.swift
//  WaterMyPlants
//
//  Created by Patrick Millet on 2/5/20.
//  Copyright © 2020 WaterMyPlants3. All rights reserved.
//

import UIKit
import CoreData

class PlantTableViewDataSource: NSObject, UITableViewDataSource {
    
    // MARK: - Properties
    
    weak var plantController: PlantController!
    weak var plantTableView: UITableView!
    
    //MARK: - TableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return plantController.plantCount
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "PlantCell",
            for: indexPath)
        guard let plant = plantController?.getPlant(at: indexPath)
            else { return cell }
        
        cell.textLabel?.text = plant.nickname
        cell.detailTextLabel?.text = plant.species
        
        return cell
       }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
         if let plantController = plantController,
                   editingStyle == .delete {
                   do {
                       try plantController.deletePlant(at: indexPath)
                       NotificationCenter.default.post(name: .dataDidUpdate, object: self)
                   } catch {
                       NSLog("Error deleting entry: \(error)")
                   }
                }
            }
        }


// MARK: - FRC Delegate

extension PlantTableViewDataSource: PersistentStoreControllerDelegate {
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        plantTableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        plantTableView.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            guard
                let newIndexPath = newIndexPath
                else { return }
            plantTableView.insertRows(at: [newIndexPath], with: .automatic)
        case .update:
            guard
                let indexPath = indexPath
                else { return }
            plantTableView.reloadRows(at: [indexPath], with: .automatic)
        case .move:
            guard
                let oldIndexPath = indexPath,
                let newIndexPath = newIndexPath
                else { return }
            plantTableView.deleteRows(at: [oldIndexPath], with: .automatic)
            plantTableView.insertRows(at: [newIndexPath], with: .automatic)
        case .delete:
            guard let indexPath = indexPath else { return }
            plantTableView.deleteRows(at: [indexPath], with: .automatic)
        @unknown default:
            NSLog("Unknown Core Data returned")
        }
    }
}
