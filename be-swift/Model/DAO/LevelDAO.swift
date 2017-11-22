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
    func getChallengesByLevel (handler: LevelHandler, level: String,  challengesView: CollectionChallengeView) {
        
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
                let correct_answer = item.value.object(forKey: "correct_answer") as! NSArray
                let estimated_time = item.value.object(forKey: "estimated_time") as! Int
                let feedback_answer = item.value.object(forKey: "feedback") as! String
                let mechanics = item.value.object(forKey: "mechanics") as! String
                let options = item.value.object(forKey: "options") as! NSArray
                let tags = item.value.object(forKey: "tags") as! NSArray
                let question =  item.value.object(forKey: "question") as! String
                let id = item.value.object(forKey: "id") as! Int
                let resource_link = item.value.object(forKey: "resource_link") as! String
                let example_code = item.value.object(forKey: "example_code") as! String
                
                // Create a challenge object
                let challenge = Challenge(question: question, estimatedTime: estimated_time, mechanics: mechanics, options:options, correctAnswer: correct_answer, feedbackAnswer:feedback_answer, tags: tags, id:id, resource_link:resource_link, exampleCode: example_code)

                // List of all challenges from a specific level
                challenges.append(challenge)
            }
            // Create a level object with all challenges from a level
            let level = Level (star: 3, level: "Level1", xp: 10, challenge: challenges)

            // Handler for asynchronous call in LevelController
            handler.getLevelData(level: level,  challengesView: challengesView)
        })
    }
}
