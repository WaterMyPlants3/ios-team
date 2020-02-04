//
//  NotificationController.swift
//  WaterMyPlants
//
//  Created by Patrick Millet on 2/4/20.
//  Copyright © 2020 WaterMyPlants3. All rights reserved.
//

import UIKit
import UserNotifications

class NotificationController {
    
    @objc func setUpNotification() {
    let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: .alert, completionHandler: <#T##(Bool, Error?) -> Void#>)
        
        
    }
    
    
}
