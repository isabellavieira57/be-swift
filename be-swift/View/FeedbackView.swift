//
//  FeedbackView.swift
//  be-swift
//
//  Created by Isabella Vieira on 08/10/17.
//  Copyright © 2017 Isabella Vieira. All rights reserved.
//

import Foundation
import UIKit

class FeedbackView: View {
    
//    var correctAnswerLabel: UILabel!
//    var wrongAnswerLabel: UILabel!
    var userAnswerLabel:UILabel!
    var explanationLabel: UILabel!
    var endButton: UIButton!
    
    let view = View(frame: CGRect.zero)
    
    let widhtiPhoneSE: CGFloat = 320
    let heightiPhoneSE: CGFloat = 568
    let screenSize = UIScreen.main.bounds
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor(red:0.96, green:0.96, blue:0.96, alpha:1.0)
        
    }
    
    convenience init (frame: CGRect, titleText: String, dismissButtonAction: Selector, helpButtonAction: Selector, questionText: String, exampleCodeText: String?, options: Array<String>, correctAnswer: Array<String>, userAnswer: Array<String>,answerIsRight: Bool, feedback: String)
    {
        self.init(frame: frame)
    
        let rectangle = view.setTopBar()
        let title = view.setTitle(title: titleText)
        let dismissButton = view.setdismissButton(dismissButtonAction: dismissButtonAction)
        let helpButton = view.setHelpButton(helpButtonAction: helpButtonAction)
        let question = view.setQuestion(questionText: questionText)
        let code = view.setExempleCode(exampleCodeText: exampleCodeText!, view: self)
        
        self.layer.addSublayer(rectangle)
        self.addSubview(title)
        self.addSubview(dismissButton)
        self.addSubview(helpButton)
        self.addSubview(question)
        self.addSubview(code)
        
        setLabelUserAnswer(correctAnswer: correctAnswer, userAnswer: userAnswer, answerIsRight: answerIsRight)
        setLabelExplanation(feedback: feedback, correctAnswer: correctAnswer, answerIsRight: answerIsRight)
        setButton(answerIsRight: answerIsRight)
        
    }
    
    func setLabelUserAnswer(correctAnswer: Array<String>, userAnswer: Array<String>, answerIsRight: Bool)
    {
        
        let xScale = screenSize.width/widhtiPhoneSE
        let yScale = screenSize.height/heightiPhoneSE
        let correctAnswerTxt = correctAnswer[0]
        let userAnswerTxt = userAnswer[0]
        var labelText: String!
        var textColor: UIColor!
        
        if answerIsRight == true
        {
            labelText = "You answered correctly: "
            textColor = UIColor(red:0.82, green:1.9, blue:0.91, alpha:1.0)

        } else
        {
            labelText = "Your answer: "
            textColor = UIColor(red:2.35, green:0.32, blue:0.57, alpha:1.0)
        }
        
        self.userAnswerLabel = UILabel(text: labelText + String(describing: userAnswer), font: "SanFranciscoText-Medium", fontSize: 16, aligment: .left, textColor: textColor, frame: CGRect(x: 24*xScale,y: 223*yScale, width: 273*xScale, height: 38*yScale))
        self.userAnswerLabel.lineBreakMode = .byWordWrapping
        self.userAnswerLabel.numberOfLines = 3
        //resizing
        
        self.addSubview(userAnswerLabel)
    }
    
    func setLabelExplanation(feedback: String, correctAnswer: Array<String>, answerIsRight: Bool)
    {
        
        let xScale = screenSize.width/widhtiPhoneSE
        let yScale = screenSize.height/heightiPhoneSE
        var explanationText: String
        var correctAnswerText = correctAnswer[0]
        
        if answerIsRight == true
        {
            explanationText = feedback
        } else
        {
            explanationText = "Correct Answer: \(correctAnswerText) \n \(feedback)"
        }
        
        let explanationLabelY = self.userAnswerLabel.frame.origin.y + self.userAnswerLabel.frame.height + 10
        
        self.explanationLabel = UILabel(text: explanationText, font: "SanFranciscoText-Medium", fontSize: 16, aligment: .left, textColor: UIColor(red:0.21, green:0.23, blue:0.47, alpha:1.0), frame: CGRect(x: 24*xScale,y: explanationLabelY, width: 273*xScale, height: 120*yScale))
        self.explanationLabel.lineBreakMode = .byWordWrapping
        self.explanationLabel.numberOfLines = 20
    //resizing
        
        self.addSubview(explanationLabel)
    }
    
    func setButton(answerIsRight: Bool) {
        
        let xScale = screenSize.width/widhtiPhoneSE
        let yScale = screenSize.height/heightiPhoneSE
        
        var imageButton: String
        
        if answerIsRight == true {
            imageButton = "continueButton"
        } else {
            imageButton = "waitButton"
        }
        
        self.endButton = UIButton(image: imageButton, frame: CGRect(x: 0, y: 0, width: 288, height: 46), target: self)
        let yPostionLastLabel = explanationLabel.frame.minY
        
        if yPostionLastLabel < 568*yScale{
            endButton.frame.origin = CGPoint(x: 16*xScale, y: screenSize.height - 80*yScale)
        } else {
            endButton.frame.origin = CGPoint(x: 16*xScale, y: yPostionLastLabel + 70*yScale)
        }
        
        self.addSubview(endButton)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
