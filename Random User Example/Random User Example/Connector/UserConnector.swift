//
//  UserConnector.swift
//  Random User Example
//
//  Created by Diego López Bugna on 18/04/2018.
//  Copyright © 2018 Diego López Bugna. All rights reserved.
//

import Foundation

protocol UserConnectorProtocol {
    func getUsers(completion: @escaping ([User]?) -> ())
}

class UserConnector : UserConnectorProtocol {
    
    let getUsersUrl: String = "https://randomuser.me/api/?results=%i"
    let quantity: Int = 50 // TODO: move to param
    
    func getUsers(completion: @escaping ([User]?) -> ()) {

        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let url = URL(string: String(format: getUsersUrl, quantity))!
        NSLog("URL: %@", url.absoluteString)
        
        let task = session.dataTask(with: url) { (data, response, error) in
            
            guard error == nil else {
                NSLog("ERROR: %@", error!.localizedDescription)
                completion(nil)
                return
            }
            guard let data = data else {
                NSLog("DATA NIL")
                completion(nil)
                return
            }
            
            var users: [User] = []
            let json = try? JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
            
            for case let result in (json!["results"] as! [[String: Any]]) {
                print("RESULT:", result) // random user api gives same thumbnail for different persons!!!
                let user = User(json: result)
                users.append(user)
            }
            
            completion(users)
        }
        task.resume()
    }
}

extension User {
    convenience init(json: [String: Any]) {
        self.init()
        username = (json["login"] as? [String: Any])?["username"] as? String
        email = json["email"] as? String
        let nameJson = json["name"] as? [String: Any]
        firstName = nameJson?["first"] as? String
        lastName = nameJson?["last"] as? String
        let pictureJson = json["picture"] as? [String: Any]
        thumbnailUrl = pictureJson?["thumbnail"] as? String
        largeImageUrl = pictureJson?["large"] as? String
    }
}
