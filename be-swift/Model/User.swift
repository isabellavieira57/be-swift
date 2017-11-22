//
//  User.swift
//  be-swift
//
//  Created by Isabella Vieira on 08/10/17.
//  Copyright © 2017 Isabella Vieira. All rights reserved.
//
import Foundation


class User {
    
    /*public var name: String
    public var email: String
    public var password: String
    public var xpTotal: Int
    public var starTotal: Int*/
    private var userDAO: UserDAO = UserDAO.sharedInstance
    
    // MARK: Singleton
    static let sharedInstance = User()
    
    private init(){
        
    }
    
    /*init (name: String, email: String, password: String, xpTotal: Int, starTotal: Int) {
        self.name = name
        self.email = email
        self.password = password
        self.xpTotal = xpTotal
        self.starTotal = starTotal
    }*/
}
