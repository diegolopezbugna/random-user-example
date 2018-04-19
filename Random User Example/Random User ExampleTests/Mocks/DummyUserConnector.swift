//
//  DummyUserConnector.swift
//  Random User ExampleTests
//
//  Created by Diego López Bugna on 19/04/2018.
//  Copyright © 2018 Diego López Bugna. All rights reserved.
//

import Foundation

class DummyUserConnector : UserConnectorProtocol {
    
    func getUsers(completion: @escaping ([User]) -> ()) {
        
        let user = User()
        user.firstName = "TEST"
        let users = [user, user]
        
        completion(users)
    }
}

