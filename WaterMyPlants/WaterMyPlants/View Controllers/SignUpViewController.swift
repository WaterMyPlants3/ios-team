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
    
    var userController = UserController()
        
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func SignUpButtonTapped(_ sender: UIButton) {
         if let username = userNameTextField.text,
            let password = passwordTextField.text,
            let phoneNumber = phoneNumberTextField.text {
            userController.signUp(with: User(username: username,
                                             password: password,
                                             phoneNumber: phoneNumber)) { (error) in 
                if let error = error {
                    print("Error sign up: \(error.localizedDescription)")
                } else {
                    self.performSegue(withIdentifier: Keys.signToTableView, sender: self)
                }
            }
        }
    }
    
   

}
