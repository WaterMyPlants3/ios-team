//
//  Plant+Convenience.swift
//  WaterMyPlants
//
//  Created by Patrick Millet on 2/1/20.
//  Copyright © 2020 WaterMyPlants3. All rights reserved.
//

import Foundation
import CoreData


 extension Plant: Persistable {
    // Need initalizers to handle representation and local inits
 }

/*
 
 server -> 4
 
 plantH20Frequency {
 (server#) Date().TimeintervalFromnow() / (server#) -> points in a 24 hour period -> In case of 4... Every 6 hours send notification
 
 Notification @12:00 and 6:00 -> 2 -> (twice a day) -> 2 (coreData comparison) check if there are Dates already associated with a plant, in that case ignore 12 12 -> return what's stored
 }
 */
