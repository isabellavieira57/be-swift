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
    
    
    // The level should be level-1, level-2... (as it is in the database)
    init(level: String) {
         self.ref = ref.child(level)
    }
    
    
    func getChallenges () {
        /*if (!AppDelegate.isAlreadyLaunchedOnce) {
            FirebaseApp.configure()
            AppDelegate.isAlreadyLaunchedOnce = true
        }*/
        
        print ("GET CHALLENGES")
        
        //refHandle = ref.child("be-swift").observe(DataEventType.value, with: { (snapshot) in
        refHandle = ref.observe(DataEventType.value, with: { (snapshot) in
            print ("SNAPSHOT")
            //let dataDict = snapshot.value as? [String : AnyObject] ?? [:]
             let dataDict = snapshot.value as! [String: AnyObject]
            print (">>> DATADICT: \(dataDict)")
            for item in dataDict {
                print (">>> key: \(item.key)")
                let correct_answer = item.value["correct_answer"] as! String
                print (">>> VALUE: \(correct_answer)")
                
                
                
            }
        })
        
    }
}

