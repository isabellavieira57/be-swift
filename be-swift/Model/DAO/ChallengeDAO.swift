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
    
    var ref = Database.database().reference().child("be-swift")
    var refHandle: UInt!
    
    
    init() {}
    
    
    func getChallenges () {
        /*if (!AppDelegate.isAlreadyLaunchedOnce) {
            FirebaseApp.configure()
            AppDelegate.isAlreadyLaunchedOnce = true
        }*/
        
        print ("GET CHALLENGES")
        
        refHandle = ref.child("be-swift").observe(DataEventType.value, with: { (snapshot) in
            print ("SNAPSHOT")
            let dataDict = snapshot.value as? [String : AnyObject] ?? [:]
            print (">>> DATADICT: \(dataDict)")
            for item in dataDict {
                print (">>> ITEM: \(item)")
            }
        })
        
    }
}

