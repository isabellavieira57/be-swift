//
//  UserChallengeInfo.swift
//  be-swift
//
//  Created by Isabella Vieira on 08/10/17.
//  Copyright © 2017 Isabella Vieira. All rights reserved.
//

import Foundation

class UserChallengeInfo {
    
    //var xpChallenge: Int
    var starChallenge: String
    var timeToAnswerChallenge: String
    var idChallenge: String
    
    init (idChallenge: String, starChallenge: String, timeToAnswerChallenge: String) {
        //self.xpChallenge = xpChallenge
        self.idChallenge = idChallenge
        self.starChallenge = starChallenge
        self.timeToAnswerChallenge = timeToAnswerChallenge
        
    }
    
}
