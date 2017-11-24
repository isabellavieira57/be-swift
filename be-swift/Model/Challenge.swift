//
//  Challenge.swift
//  be-swift
//
//  Created by Isabella Vieira on 08/10/17.
//  Copyright © 2017 Isabella Vieira. All rights reserved.
//

import Foundation

class Challenge {
    
    var id: Int
    var resource_link: String
    var question: String
    var exampleCode: String
    var estimatedTime: Double
    var mechanics: String
    var options: NSArray
    var correctAnswer: NSArray = []
    var feedbackAnswer: String
    var tags: NSArray
    
    init (question: String, estimatedTime: Double, mechanics: String, options: NSArray, correctAnswer: NSArray, feedbackAnswer: String, tags: NSArray, id: Int, resource_link: String, exampleCode: String) {
        self.question = question
        self.estimatedTime = estimatedTime
        self.mechanics = mechanics
        self.options = options
        self.correctAnswer = correctAnswer
        self.feedbackAnswer = feedbackAnswer
        self.tags = tags
        self.id = id
        self.resource_link = resource_link
        self.exampleCode = exampleCode
    }
}
