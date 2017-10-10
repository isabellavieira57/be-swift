//
//  User.swift
//  be-swift
//
//  Created by Isabella Vieira on 08/10/17.
//  Copyright © 2017 Isabella Vieira. All rights reserved.
//

import Foundation


class User {
    
    var name: String
    var email: String
    var password: String
    var xpTotal: Int
    var starTotal: Int
    
    init (name: String, email: String, password: String, xpTotal: Int, starTotal: Int) {
        self.name = name
        self.email = email
        self.password = password
        self.xpTotal = xpTotal
        self.starTotal = starTotal
    }
    
    
}
