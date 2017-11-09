//
//  FeedbackViewController.swift
//  be-swift
//
//  Created by Ana Müller on 11/7/17.
//  Copyright © 2017 Isabella Vieira. All rights reserved.
//

import Foundation
import UIKit

class FeedbackViewController: UIViewController
{
    var feedbackView: FeedbackView!
    var challenge: Challenge!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
//        self.feedbackView = FeedbackView(frame: CGRect.zero, titleText: self.challenge.tags[0] as! String, dismissButtonAction: #selector(dismissButton), helpButtonAction: #selector(helpButton), questionText: self.challenge.question, exampleCodeText: self.challenge.exampleCode, options: self.challenge.options as! Array<String>, correctAnswer: self.challenge.correctAnswer, userAnswer: <#T##Array<String>#>, answerIsRight: <#T##Bool#>, feedback: self.challenge.feedbackAnswer)
    }
    
    
}

