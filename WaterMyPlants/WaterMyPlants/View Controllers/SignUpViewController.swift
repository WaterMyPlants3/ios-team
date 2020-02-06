//
//  SignUpViewController.swift
//  WaterMyPlants
//
//  Created by Lambda_School_Loaner_218 on 2/3/20.
//  Copyright © 2020 WaterMyPlants3. All rights reserved.
//

import UIKit
import CoreData

class SignUpViewController: UIViewController {
    
    var userController = UserController() // Use shared instance to segue into view controller after sign in with the given username and password
        
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func SignUpButtonTapped(_ sender: UIButton) {
        let phoneNumber = "123-456-7890"
         if let username = userNameTextField.text,
            let password = passwordTextField.text {
            userController.signUp(with: User(username: username,
                                             password: password,
                                             phoneNumber: phoneNumber)) { (error) in 
                if let error = error {
                    // Alert Controller in here to say "That username already exists"
                    print("Error sign up: \(error.localizedDescription)")
                } else {
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
    }
}
