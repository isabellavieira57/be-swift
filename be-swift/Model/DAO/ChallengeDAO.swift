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

class ChallengeDAO {
    
    var ref = Database.database().reference()
    var refHandle: UInt!
    
    // MARK: Singleton
    static let sharedInstance = ChallengeDAO()
    
    // MARK: Initializer
    init (){}
    
    // The level should be level-1, level-2... (as it is in the database)
    //init(level: String) {
    //     self.ref = ref.child(level)
    //}
    
    // MARK: Methods
    func getChallenges (handler: ChallengeHandler, level: String){
        if (!AppDelegate.isAlreadyLaunchedOnce) {
            FirebaseApp.configure()
            AppDelegate.isAlreadyLaunchedOnce = true
        }
        
        self.ref = ref.child(level)
        refHandle = ref.observe(DataEventType.value, with: { (snapshot) in
         let dataDict = snapshot.value as! [String: AnyObject]
            for item in dataDict {
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

                
                //let challenge = Challenge(question: question, estimatedTime: estimated_time, mechanics: mechanics, options: options, correctAnswer: correct_answer, feedbackAnswer: feedback_answer, tags: tags)
                //handler.addChallenge(challenge: challenge)
               // print (">>> key: \(item.key)")
               // let correct_answer = item.value["correct_answer"] as! String
               // print (">>> VALUE: \(correct_answer)")

            }
        })
    }
}

