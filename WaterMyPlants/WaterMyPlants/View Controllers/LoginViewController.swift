//
//  LoginViewController.swift
//  WaterMyPlants
//
//  Created by Lambda_School_Loaner_218 on 2/3/20.
//  Copyright © 2020 WaterMyPlants3. All rights reserved.
//

import UIKit
import CoreData

class LoginViewController: UIViewController {
    
    var userController: UserController!
    
    @IBOutlet weak var userNameTextField:UITextField!
    @IBOutlet weak var passWordTextField: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func signInButtonTapped(_ sender: UIButton) {
        guard let username = userNameTextField.text,
            let password = passWordTextField.text else { return }
        
            userController.signIn(with: User(username: username, password: password)) { error in
                if let error = error {
                    print("Error loggingin: \(error.localizedDescription)")
                } else {
                    self.performSegue(withIdentifier: Keys.logInToTableView, sender: self)
                }
            }
        }
    }
