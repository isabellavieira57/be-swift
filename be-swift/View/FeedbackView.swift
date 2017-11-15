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
    
    var labelCorrectUserAnswer:UILabel!
    var labelWrongUserAnswer:UILabel!
    var labelCorrectAnswer:UILabel!
    var labelExplanation: UILabel!
    var buttonContinue: UIButton!
    
    var sizeView: CGFloat!
    
    let view = View(frame: CGRect.zero)
    
    let widhtiPhoneSE: CGFloat = 320
    let heightiPhoneSE: CGFloat = 568
    let screenSize = UIScreen.main.bounds
    let xScale: CGFloat = 0
    let yScale: CGFloat = 0
    
    //variables to set userAnswer labels
    var userAnswerFrame = CGRect(x: 24,y: 223, width: 273, height: 38)
    let userAnswerFont = "SanFranciscoText-Medium"
    let userAnswerFontSize: CGFloat = 16
    let userAnswerAlignment = NSTextAlignment.left
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor(red:0.96, green:0.96, blue:0.96, alpha:1.0)
        
    }

    convenience init (titleText: String, dismissButtonAction: Selector, helpButtonAction: Selector, questionText: String, exampleCodeText: String?, continueButtonAction: Selector)
    {
        self.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 2000))

        let xScale = screenSize.width/widhtiPhoneSE
        let yScale = screenSize.height/heightiPhoneSE

        let rectangle = view.setTopBar()
        let title = view.setTitle(title: titleText)
        let dismissButton = view.setdismissButton(dismissButtonAction: dismissButtonAction)
        let helpButton = view.setHelpButton(helpButtonAction: helpButtonAction)
        let question = view.setQuestion(questionText: questionText)
        let code = view.setExempleCode(exampleCodeText: exampleCodeText!, view: self)
        
        let height = sizeView!
        self.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: height)

        self.layer.addSublayer(rectangle)
        self.addSubview(title)
        self.addSubview(dismissButton)
        self.addSubview(helpButton)
        self.addSubview(question)
        self.addSubview(code)
    }
    
    func setLabelUserAnswer(labelText: String)
    {
        self.labelCorrectUserAnswer = UILabel(text: "You answered correctly: " + labelText, font: userAnswerFont, fontSize: userAnswerFontSize, aligment: userAnswerAlignment, textColor: UIColor(red:0.28, green:0.64, blue:0.31, alpha:1.0), frame: userAnswerFrame)
        let heightCorrectAnswer = heightForView(text: self.labelCorrectUserAnswer.text!, font: labelCorrectUserAnswer.font, width: userAnswerFrame.width)
        self.labelCorrectUserAnswer.frame = CGRect(x: 24*xScale, y: 238*yScale, width: 273*xScale, height: heightCorrectAnswer)
//        self.userAnswerLabel.lineBreakMode = .byWordWrapping
//        self.userAnswerLabel.numberOfLines = 3
        
        self.labelWrongUserAnswer = UILabel(text: "Your answer: " + labelText, font: userAnswerFont, fontSize: userAnswerFontSize, aligment: userAnswerAlignment, textColor: UIColor(red:2.35, green:0.32, blue:0.57, alpha:1.0), frame: userAnswerFrame)
        let heightWrongAnswer = heightForView(text: labelWrongUserAnswer.text!, font: labelWrongUserAnswer.font, width: userAnswerFrame.width)
        self.labelWrongUserAnswer.frame = CGRect(x: 24*xScale, y: 238*yScale, width: 273*xScale, height: heightWrongAnswer)
    }
    
    func setCorrectChallengeAnswer(labelText: String)
    {
        let xScale = screenSize.width/widhtiPhoneSE
        let yScale = screenSize.height/heightiPhoneSE
        
        let yPosition = self.userAnswerFrame.origin.y + self.userAnswerFrame.height
        
        self.labelCorrectAnswer = UILabel(text: "Correct answer: " + labelText, font: userAnswerFont, fontSize: userAnswerFontSize, aligment: userAnswerAlignment, textColor: UIColor(red:0.21, green:0.23, blue:0.47, alpha:1.0), frame: CGRect(x: userAnswerFrame.origin.x, y: yPosition, width: userAnswerFrame.width, height: userAnswerFrame.height))
        let height = heightForView(text: labelCorrectAnswer.text!, font: labelCorrectAnswer.font, width: labelCorrectAnswer.frame.width)
        self.labelCorrectAnswer.frame = CGRect(x: 24*xScale, y: yPosition + 10*yScale, width: 273*xScale, height: height)
    }
    
    func setLabelExplanation(labelText: String, previousLabel: UILabel)
    {
        
        let xScale = screenSize.width/widhtiPhoneSE
        let yScale = screenSize.height/heightiPhoneSE
        
        let explanationLabelY = previousLabel.frame.origin.y + previousLabel.frame.height
        
        self.labelExplanation = UILabel(text: "Explanation: " + labelText, font: userAnswerFont, fontSize: userAnswerFontSize, aligment: userAnswerAlignment, textColor: UIColor(red:0.21, green:0.23, blue:0.47, alpha:1.0), frame: CGRect(x: userAnswerFrame.origin.x,y: explanationLabelY, width: 273, height: 120))
        let height = heightForView(text: labelText, font: labelExplanation.font, width: labelExplanation.frame.width)
        self.labelExplanation.frame = CGRect(x: 24*xScale, y: explanationLabelY + 10*yScale, width: 273*xScale, height: height)
//        self.explanationLabel.lineBreakMode = .byWordWrapping
//        self.explanationLabel.numberOfLines = 20
    }
    
    func setButton() {
        
        let xScale = screenSize.width/widhtiPhoneSE
        let yScale = screenSize.height/heightiPhoneSE
                
        self.buttonContinue = UIButton(image: "continue", frame: CGRect(x: 16*xScale, y: screenSize.height - 80*yScale, width: 288*xScale, height: 46*yScale), target: self)
        let yPostionLastLabel = labelExplanation.frame.minY
        
        if yPostionLastLabel < 568*yScale{
            buttonContinue.frame.origin = CGPoint(x: 16*xScale, y: screenSize.height - 80*yScale)
            sizeView = screenSize.height

        } else {
            buttonContinue.frame.origin = CGPoint(x: 16*xScale, y: yPostionLastLabel + 62*yScale)
            sizeView = buttonContinue.frame.minY + 62*yScale
        }
    }
    
    override func heightForView(text:String, font:UIFont, width:CGFloat) -> CGFloat
    {
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        label.sizeToFit()
        
        return label.frame.height
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
}
