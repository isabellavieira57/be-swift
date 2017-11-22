//
//  User.swift
//  be-swift
//
//  Created by Isabella Vieira on 08/10/17.
//  Copyright © 2017 Isabella Vieira. All rights reserved.
//
import Foundation


class User {
    
    // MARK: Attributes
    var name: String?
    var email: String?
    var password: String?
    var xpTotal: Int?
    var starTotal: Int?
    
    // MARK: DAO instance
    var userDAO: UserDAO = UserDAO.sharedInstance
    
    // MARK: Singleton
    static let sharedInstance = User()
    
    init(){}
    
    //MARK: Methods
    func login(email: String, password: String) {
        userDAO.loadUser(email: email, password: password)
    }
    
    func checkLogedIn() -> Bool {
        if UserDAO.sharedInstance.checkLoadedUser() {
            print("PessoaInterf - usuario ja logado")
            return true
        }
        return false
    }
    
    func logout () {
        userDAO.logout()
        self.name = ""
        self.email = ""
        self.password = ""
        self.xpTotal = 0
        self.starTotal = 0
    }
    
    func register (email: String, password: String) {
        userDAO.registerUser(email: email, password: password)
    }
    
    func saveRegistration (email: String, password: String) {
        userDAO.saveRegistration(email: email, password: password)
    }


}
