//
//  LevelDAO.swift
//  be-swift
//
//  Created by Isabella Vieira on 08/10/17.
//  Copyright © 2017 Isabella Vieira. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

class LevelDAO {
    
    var ref: DatabaseReference!
    var refHandle: UInt!
    
    // MARK: Singleton
    static var sharedInstance = LevelDAO()
    
    // MARK: Initializer
    init (){
        self.ref = Database.database().reference()
    }
    
    // MARK: Methods
    func getChallengesByLevel (handler: LevelHandler, level: String) {
        
        var challenges: [Challenge] = []
        
        // If AppDelegate doesn't lauch firebase configuration
        if (!AppDelegate.isAlreadyLaunchedOnce) {
            FirebaseApp.configure()
            AppDelegate.isAlreadyLaunchedOnce = true
        }
    
        // Initialize in the level node in firebase database
        self.ref = self.ref.child(level)
        
        // Observe database and retrieve data
        refHandle = self.ref.observe(DataEventType.value, with: { (snapshot) in
            let dataDict = snapshot.value as! [String: AnyObject]
            
            // Parse json data from database
            for item in dataDict {
                let correct_answer = item.value["correct_answer"] as! String
                let estimated_time = item.value["estimated_time"] as! Int
                let feedback_answer = item.value["feedback_answer"] as! String
                let mechanics = item.value["mechanics"] as! String
                let options = item.value["options"] as! NSArray
                let tags = item.value["tags"] as! NSArray
                let question =  item.value["question"] as! String

                // Create a challenge object
                let challenge = Challenge(question: question, estimatedTime: estimated_time, mechanics: mechanics, options: options, correctAnswer: correct_answer, feedbackAnswer: feedback_answer, tags: tags)
                
                // List of all challenges from a specific level
                challenges.append(challenge)
            }
            
            // Create a level object with all challenges from a level
            let level = Level (star: 3, level: "Basico", xp: 10, challenge: challenges)
            
            // Handler for asynchronous call in LevelController
            handler.getLevelData(level: level)
            
        })
        
    }
}
