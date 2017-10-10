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
    var estimatedTime: String
    var mechanics: String
    var challengeId: Int
    var options: String // list
    var correctAnswer: String // list
    var feedbackAnswer: String
    
    init (question: String, estimatedTime: String, mechanics: String, challengeId: Int , options: String, correctAnswer: String, feedbackAnswer: String) {
        self.question = question
        self.estimatedTime = estimatedTime
        self.mechanics = mechanics
        self.challengeId = challengeId
        self.options = options
        self.correctAnswer = correctAnswer
        self.feedbackAnswer = feedbackAnswer
    }
    
}
