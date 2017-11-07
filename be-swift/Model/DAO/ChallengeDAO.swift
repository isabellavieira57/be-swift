//
//  ChallengeDAO.swift
//  be-swift
//
//  Created by Isabella Vieira on 08/10/17.
//  Copyright © 2017 Isabella Vieira. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase


// LevelDAO
class LevelDAO {
    
    var ref: DatabaseReference!
    var refHandle: UInt!
    
    // MARK: Singleton
    static var sharedInstance = ChallengeDAO()
    
    // MARK: Initializer
    init (){
        //self.ref = Database.database().reference()
    }
    
    // The level should be level-1, level-2... (as it is in the database)
    //init(level: String) {
    //     self.ref = ref.child(level)
    //}
    
    // MARK: Methods
    //func getLevel (handler: ChallengeHandler, level: String) --> Level {
    func getLevel (handler: ChallengeHandler, level: String) {
        
        print (">>> ENTREI NO GET CHALLENGE- CHALLENGES DAO")
        
        if (!AppDelegate.isAlreadyLaunchedOnce) {
            FirebaseApp.configure()
            AppDelegate.isAlreadyLaunchedOnce = true
         }
        
        self.ref = self.ref.child(level)
        refHandle = self.ref.observe(DataEventType.value, with: { (snapshot) in
         let dataDict = snapshot.value as! [String: AnyObject]
            for item in dataDict {
                
                print (">>> SNAPSHOT")
                
                let correct_answer = item.value["correct_answer"] as! String
                let estimated_time = item.value["estimated_time"] as! Int
                let feedback_answer = item.value["feedback_answer"] as! String
                let mechanics = item.value["mechanics"] as! String
                let options = item.value["options"] as! NSArray
                let tags = item.value["tags"] as! NSArray
                let question =  item.value["question"] as! String
                
                print (correct_answer)
                print (estimated_time)
                print (feedback_answer)
                print (mechanics)
                print (options)
                print (tags)
                print (question)

                // TODO: Criar convenient init que recebe json do challenge e devolve  o challenge
                let challenge = Challenge(question: question, estimatedTime: estimated_time, mechanics: mechanics, options: options, correctAnswer: correct_answer, feedbackAnswer: feedback_answer, tags: tags)
                
                
                handler.addChallenge(challenge: challenge)
                
                
               // print (">>> key: \(item.key)")
               // let correct_answer = item.value["correct_answer"] as! String
               // print (">>> VALUE: \(correct_answer)")

            }
        })
    }
}

