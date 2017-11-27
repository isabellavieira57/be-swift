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
    // MARK: Initializer
    init (){
        self.ref = Database.database().reference()
    }
    
    //MARK: Methods
    func loadUser(handler: UserHandler, email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            var success: Bool = true
            if (error == nil) {
                print("You have successfully logged in")
                success = true
                print ("::loadUser - UserDAO - Sucesso:: \(success)")
            }
            else {
                print("Login falhou")
                success = false
                print ("::loadUser - UserDAO - Falhou:: \(success)")
            }
        handler.loginUser(success: success)
        }
    }
    
    func checkLoadedUser() -> Bool {
        if let user = Auth.auth().currentUser {
            User.sharedInstance.email = user.email!
            return true
        }
        return false
    }
    
    func registerUser(handler: UserHandler, email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
            var success: Bool = true
            if error == nil {
                print("DAO - usuario criado")
                success = true
                self.loadUser(handler: handler, email: email, password: password)
            } else {
                print(error?.localizedDescription ?? "DAO - erro no registro")
                success = false
            }
            handler.loginUser(success: success)
        })
    }
    
    func logout() {
        try! Auth.auth().signOut()
        print("DAO - Logged out")
    }
    
    func saveRegistration(name: String, email: String, password: String, country: String, major: String) {
        // If AppDelegate doesn't lauch firebase configuration
        if (!AppDelegate.isAlreadyLaunchedOnce) {
            FirebaseApp.configure()
            AppDelegate.isAlreadyLaunchedOnce = true
        }
        
        let emailUser = email.replacingOccurrences(of: ".", with: "_")
        
        // salva nome em um nó separado
        let ref = Database.database().reference().child("UsersData").child(emailUser)
        let data = ["name": name, "country": country, "major": major]
        ref.setValue(data)
    }
    
    func saveChallengeData (email: String, challenge_id: Int, stars: Int, time: Double) {
        
        print ("ENTROU NO SAVE CHALLENGS DATA")
        // If AppDelegate doesn't lauch firebase configuration
        if (!AppDelegate.isAlreadyLaunchedOnce) {
            FirebaseApp.configure()
            AppDelegate.isAlreadyLaunchedOnce = true
        }
        
        let challengeID = String(challenge_id)
        let emailUser = email.replacingOccurrences(of: ".", with: "_")
        let string = "challenge_" + challengeID
        let ref = Database.database().reference().child("UsersData").child(emailUser).child("Challenges").child(string)
        let data = ["timeToAnswer": Int(time), "stars": stars]
        ref.setValue(data)
    }
    
    // MARK: Methods
    func getChallengeInfoByUser (handler: LevelHandler, email:String) {
        
        var userChallengesInfo: [UserChallengeInfo] = []
        
        // If AppDelegate doesn't lauch firebase configuration
        if (!AppDelegate.isAlreadyLaunchedOnce) {
            FirebaseApp.configure()
            AppDelegate.isAlreadyLaunchedOnce = true
        }
       
        let emailUser = email.replacingOccurrences(of: ".", with: "_")
        
       // print ("Email user: ", emailUser)
        // Initialize in the level node in firebase database
        self.ref = self.ref.child("UsersData").child(emailUser).child("Challenges")
        //self.ref = self.ref.child("UsersData").child(emailUser)
        print ("REF: \(self.ref)")
        
        // Observe database and retrieve data
        refHandle = self.ref.observe(DataEventType.value, with: { (snapshot) in
            //let dataDict = snapshot.value as! [String: AnyObject]
            
            if snapshot.exists() {
                //let dataDict = snapshot.value as! [String: AnyObject]
                let dataDict = snapshot.value as! [String:  AnyObject]
                //let dataDict = snapshot.value
                print (">>>> DATA DICT: ", dataDict)
            
                // Parse json data from database
                for item in dataDict {
                    var id = item.key as String
                    if id.contains("_") {
                        let endIndex = id.range(of: "_")!.upperBound
                        id = id.substring(from: endIndex).trimmingCharacters(in: .whitespacesAndNewlines)
                    }
                    print ( "id: \(id)")
                    let stars = item.value.object(forKey: "stars") as! Int
                    print ( "stars: \(stars)")
                    let timeToAnswer = item.value.object(forKey: "timeToAnswer")  as! Int 
                    print ( "time: \(timeToAnswer)")



                    // Create a userChallengeInfo object
                    let userChallengeInfo = UserChallengeInfo(idChallenge: id, starChallenge: stars , timeToAnswerChallenge: timeToAnswer)

                    // List of all info of a user
                    userChallengesInfo.append(userChallengeInfo)
                }
                // Handler for asynchronous call in LevelController
                handler.getUserChallengeInfo(userChallengeInfo: userChallengesInfo)
            }
        })
    }
    
    
}
