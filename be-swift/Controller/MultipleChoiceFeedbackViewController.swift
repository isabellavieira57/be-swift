//
//  MultipleChoiceFeedbackViewController.swift
//  be-swift
//
//  Created by Ana Müller on 11/10/17.
//  Copyright © 2017 Isabella Vieira. All rights reserved.
//

import Foundation
import UIKit

class MultipleChoiceFeedbackViewController: FeedbackViewController
{
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        //        updateLabelUserAnswer(correctAnswer: <#T##Array<String>#>, userAnswer: <#T##Array<String>#>, answerIsRight: <#T##Bool#>)
    }
    
    func updateLabelUserAnswer(correctAnswer: Array<String>, userAnswer: Array<String>, answerIsRight: Bool)
    {
        let correctAnswerTxt = correctAnswer[0]
        let userAnswerTxt = userAnswer[0]
        
        var labelText: String
        var textColor: UIColor
        
        if answerIsRight == true
        {
            labelText = "You answered correctly: " + correctAnswerTxt
            textColor = UIColor(red:0.28, green:0.64, blue:0.31, alpha:1.0)
        } else
        {
            labelText = "Your answer: " + userAnswerTxt
            textColor = UIColor(red:2.35, green:0.32, blue:0.57, alpha:1.0)
        }
    }
}
