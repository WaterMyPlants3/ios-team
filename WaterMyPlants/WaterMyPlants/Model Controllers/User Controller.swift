//
//  User Controller.swift
//  WaterMyPlants
//
//  Created by Patrick Millet on 2/3/20.
//  Copyright © 2020 WaterMyPlants3. All rights reserved.
//

import Foundation

class UserController {
    
    static let sharedInstance = UserController()
    
    private let baseURL = URL(string: "https://water-my-plant-9000.herokuapp.com/")!
    var bearer: BearerToken?
    var user: User?
    var userID: UserID?
    
    func signUp(with user: User, completion: @escaping (Error?) -> (Void)) {
        let signUpUrl = baseURL.appendingPathComponent("api/auth/register")
        
        var request = URLRequest(url: signUpUrl)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let jsonEncoder = JSONEncoder()
        do {
            let jsonData = try jsonEncoder.encode(user)
            request.httpBody = jsonData
            let jsonString = String.init(data: jsonData, encoding: .utf8)
            print(jsonString!)
        } catch {
            print("Error encoding user object \(error)")
            completion(error)
            return
        }
        
        URLSession.shared.dataTask(with: request) { (_, response, error) in
            if let error = error {
                completion(error)
                return
            }
            
            if let response = response as? HTTPURLResponse, response.statusCode != 200 || response.statusCode != 201 {
                completion(NSError(domain: "", code: response.statusCode, userInfo: nil))
                return
            }
            DispatchQueue.main.async {
            completion(nil)
            }
        }.resume()
    }
    
    // Use patricktest username and patricktest password (known working login)
    func signIn(with user: User, completion: @escaping (Error?) -> ()) {
        
        let signInUrl = baseURL.appendingPathComponent("api/auth/login")
        var request = URLRequest(url: signInUrl)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let jsonEncoder = JSONEncoder()
        do {
            let jsonData = try jsonEncoder.encode(user)
            request.httpBody = jsonData
            let jsonString = String.init(data: jsonData, encoding: .utf8)
            print(jsonString!)
        } catch {
            print("Error encoding user object \(error)")
            completion(error)
            return
        }
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(error)
                return
            }
            
            if let response = response as? HTTPURLResponse, response.statusCode != 200 {
                completion(NSError(domain: "", code: response.statusCode, userInfo: nil))
                return
            }
            
            guard let data = data else {
                completion(NSError())
                return
            }
            
            let decoder = JSONDecoder()
            do {
                self.bearer = try decoder.decode(BearerToken.self, from: data)
                self.userID = try decoder.decode(UserID.self, from: data)
                print(self.userID!)
                print(self.bearer!)
            } catch {
                print("Error decoding bearer token \(error)")
                completion(error)
                return
            }
            
            DispatchQueue.main.async {
            completion(nil)
            }
        }.resume()
    }
}
