//
//  UserDAO.swift
//  be-swift
//
//  Created by Isabella Vieira on 08/10/17.
//  Copyright © 2017 Isabella Vieira. All rights reserved.
//
import Foundation
import Firebase
import FirebaseAuth

class UserDAO {
    
    var ref: DatabaseReference!
    var refHandle: UInt!
    
    // MARK: Singleton
    static let sharedInstance = UserDAO()
    
    // MARK: Init
    private init(){}
    
    //MARK: Methods
    public func loadUser(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if (error == nil) {
                print("You have successfully logged in")
            }
            else {
                print("Login falhou")
            }
        }
    }
    
    public func checkLoadedUser() -> Bool {
        if let user = Auth.auth().currentUser {
            //User.sharedInstance.email = user.email!
            return true
        }
        return false
    }
    
    public func registerUser(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
            if error == nil {
                print("DAO - usuario criado")
                self.loadUser(email: email, password: password)
            } else {
                print(error?.localizedDescription ?? "DAO - erro no registro")
            }
        })
    }
    
    public func logout() {
        try! Auth.auth().signOut()
        print("DAO - Logged out")
    }
}
