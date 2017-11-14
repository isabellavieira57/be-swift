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
    
    let multChoiceController = MultipleChoiceController()
    
    var userAnswer: String!
    var correctAnswer: String!
    var answerIsRight: Bool!
    var challengeMultChoice: Challenge!
    var multChoiceFeedView = MultipleChoiceFeedbackView()
    var feedbackController = FeedbackViewController()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
//        self.challengeMultChoice = self.multChoiceController.challenge
//        self.correctAnswer = self.challengeMultChoice.correctAnswer[0] as! String
//        self.userAnswer = self.multChoiceController.userAnswer
//        self.answerIsRight = self.multChoiceController.answerIsRight
        
        self.challengeMultChoice = self.multChoiceController.bringVariableValues().challenge
        self.correctAnswer = self.multChoiceController.bringVariableValues().correctAnswer
        self.userAnswer = self.multChoiceController.bringVariableValues().userAnswer
        self.answerIsRight = self.multChoiceController.bringVariableValues().answerIsRight
        
        self.multChoiceFeedView.addSubview(self.feedbackController.scrollView)
        scrollView.addSubview(self.multChoiceFeedView)
        
        self.multChoiceFeedView.feedbackView.setLabelUserAnswer(labelText: self.userAnswer)
        
        setLabels()
        
        self.multChoiceFeedView.feedbackView.addSubview(self.multChoiceFeedView.feedbackView.labelExplanation)
        self.multChoiceFeedView.feedbackView.setButton()
        self.multChoiceFeedView.feedbackView.addSubview(self.multChoiceFeedView.feedbackView.buttonEnd)
    }
    
    func setLabels()
    {
        if answerIsRight == true
        {
            //add label when the user's answer is correct
            self.multChoiceFeedView.feedbackView.addSubview(self.multChoiceFeedView.feedbackView.labelCorrectUserAnswer)
            
            //set the explanation label's parameters
            self.feedbackView.setLabelExplanation(labelText: self.challenge.feedbackAnswer, previousLabel: self.feedbackView.labelCorrectUserAnswer)
            
        } else {
            // add labels when the user's answer is incorrect
            self.multChoiceFeedView.feedbackView.addSubview(self.multChoiceFeedView.feedbackView.labelWrongUserAnswer)
            self.multChoiceFeedView.feedbackView.addSubview(self.multChoiceFeedView.feedbackView.labelCorrectAnswer)
            
            //set the explanation label's parameters
            self.feedbackView.setLabelExplanation(labelText: self.challenge.feedbackAnswer, previousLabel: self.feedbackView.labelCorrectAnswer)
        }
    }
}
