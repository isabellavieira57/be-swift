//
//  Challenge.swift
//  be-swift
//
//  Created by Isabella Vieira on 08/10/17.
//  Copyright © 2017 Isabella Vieira. All rights reserved.
//

import Foundation

protocol ChallengeHandler {
    func addChallenge (challenge: Challenge)
}

class Challenge {
    
    var question: String
    var estimatedTime: Int
    var mechanics: String
    var options: NSArray // list
    var correctAnswer: String // list
    var feedbackAnswer: String
    var tags: NSArray // list
    
    

    init (question: String, estimatedTime: Int, mechanics: String, options: NSArray, correctAnswer: String, feedbackAnswer: String, tags: NSArray) {
        self.question = question
        self.estimatedTime = estimatedTime
        self.mechanics = mechanics
        self.options = options
        self.correctAnswer = correctAnswer
        self.feedbackAnswer = feedbackAnswer
        self.tags = tags
    }
    
   
    
}
