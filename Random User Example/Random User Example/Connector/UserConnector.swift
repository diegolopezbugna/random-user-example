//
//  UserConnector.swift
//  Random User Example
//
//  Created by Diego López Bugna on 18/04/2018.
//  Copyright © 2018 Diego López Bugna. All rights reserved.
//

import Foundation
import UIKit

protocol UserConnectorProtocol {
    func getUsers(completion: @escaping ([User]) -> ())
}

class DummyUserConnector : UserConnectorProtocol {

    func getUsers(completion: @escaping ([User]) -> ()) {

        let user = User()
        user.firstName = "TEST"
        let users = [user, user]
        
        completion(users)
    }
}

class UserConnector : UserConnectorProtocol {
    
    func getUsers(completion: @escaping ([User]) -> ()) {

        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let url = URL(string: "")!
        
        let task = session.dataTask(with: url) { (data, response, error) in
            if (error == nil) {
                if let data = data {
                    print("DATA: %@", data)
                }
                completion([])
            } else {
                NSLog("ERROR: %@", error!.localizedDescription)
            }
        }
        task.resume()
    }
    
    

}
