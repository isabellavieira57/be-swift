//
//  Challenge.swift
//  be-swift
//
//  Created by Isabella Vieira on 08/10/17.
//  Copyright © 2017 Isabella Vieira. All rights reserved.
//

import Foundation

class Challenge {
    
    var question: String
    var estimatedTime: Int
    var mechanics: String
    var options: NSArray
    var correctAnswer: String
    var feedbackAnswer: String
    var tags: NSArray
    
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
