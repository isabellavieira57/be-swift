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
    var multChoiceFeedView = FeedbackView()
    var feedbackController = FeedbackViewController()
    var scrollView: UIScrollView!

    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        multChoiceFeedView = FeedbackView(titleText: self.challengeMultChoice.tags[0] as! String, dismissButtonAction: #selector(dismissButton), helpButtonAction: #selector(helpButton), questionText: self.challengeMultChoice.question, exampleCodeText: self.challengeMultChoice.exampleCode, continueButtonAction: #selector(continueButton))
        
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: self.multChoiceFeedView.frame.size.width, height: self.multChoiceFeedView.frame.size.height))
        scrollView.backgroundColor = UIColor(red:0.96, green:0.96, blue:0.96, alpha:1.0)
        
        self.multChoiceFeedView.addSubview(scrollView)
        scrollView.addSubview(multChoiceFeedView)
        
        self.multChoiceFeedView.setLabelUserAnswer(labelText: self.userAnswer)
        
        setLabels()
        
        self.multChoiceFeedView.addSubview(self.multChoiceFeedView.labelExplanation)
        self.multChoiceFeedView.setButton()
//        updateButtonPosition()
        self.multChoiceFeedView.addSubview(self.multChoiceFeedView.buttonContinue)
    }
    
    func setLabels()
    {
        self.multChoiceFeedView.setLabelUserAnswer(labelText: self.userAnswer)
        self.multChoiceFeedView.setCorrectChallengeAnswer(labelText: self.correctAnswer)
        
        if answerIsRight == true
        {
            //add label when the user's answer is correct
            self.multChoiceFeedView.addSubview(self.multChoiceFeedView.labelCorrectUserAnswer)
            
            //set the explanation label's parameters
            self.feedbackView.setLabelExplanation(labelText: self.challengeMultChoice.feedbackAnswer, previousLabel: self.feedbackView.labelCorrectUserAnswer)
            
        } else {
            // add labels when the user's answer is incorrect
            self.multChoiceFeedView.addSubview(self.multChoiceFeedView.labelWrongUserAnswer)
            self.multChoiceFeedView.addSubview(self.multChoiceFeedView.labelCorrectAnswer)
            
            //set the explanation label's parameters
            self.feedbackView.setLabelExplanation(labelText: self.challengeMultChoice.feedbackAnswer, previousLabel: self.feedbackView.labelCorrectAnswer)
        }
    }
    
//    func updateButtonPosition()
//    {
//        let widhtiPhoneSE: CGFloat = 320
//        let heightiPhoneSE: CGFloat = 568
//        let screenSize = UIScreen.main.bounds
//        let xScale = screenSize.width/widhtiPhoneSE
//        let yScale = screenSize.height/heightiPhoneSE
//
//        let yPostionPreviousLabel = self.multChoiceFeedView.labelExplanation.frame.origin.y
//
//        if yPostionPreviousLabel > 568*yScale
//        {
//            self.multChoiceFeedView.buttonContinue.frame.origin = CGPoint(x: 16*xScale, y: yPostionPreviousLabel + 62*yScale)
//            self.multChoiceFeedView.sizeView = self.multChoiceFeedView.buttonContinue.frame.minY + 62*yScale
//            self.multChoiceFeedView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: self.multChoiceFeedView.sizeView)
//        }
//    }
    
    func getMultipleChoiceVariables(challenge: Challenge,userAnswer: String, correctAnswer: String, answerIsRight: Bool)
    {
        self.challengeMultChoice = challenge
        self.userAnswer = userAnswer
        self.correctAnswer = correctAnswer
        self.answerIsRight = answerIsRight
    }
    
    @objc func dismissButton(_ sender: Any){
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func helpButton(_ sender: Any){
        let webView = WebDocumentationViewController()
        webView.url = URL(string: self.challengeMultChoice.resource_link)!
        present(webView, animated: false, completion: nil)
    }
    
    @objc func continueButton(_ sender: Any)
    {
        self.dismiss(animated: true, completion: nil)
    }
    
}
