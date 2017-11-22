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
    var code: UILabel!
    
    var sizeView: CGFloat!
    
    let view = View(frame: CGRect.zero)

    //Variables used to automatically update the position and size of elements according to the user's device
    let widhtiPhoneSE: CGFloat = 320
    let heightiPhoneSE: CGFloat = 568
    let screenSize = UIScreen.main.bounds
    
    //variables to set userAnswer labels
    let userAnswerX: CGFloat = 24
    let userAnswerWidth: CGFloat = 273
    let userAnswerHeight: CGFloat = 38
    let userAnswerFont = "SanFranciscoText-Medium"
    let userAnswerFontSize: CGFloat = 16
    let userAnswerAlignment = NSTextAlignment.left
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor(red:0.96, green:0.96, blue:0.96, alpha:1.0)
        
    }

    convenience init (titleText: String, dismissButtonAction: Selector, helpButtonAction: Selector, questionText: String, exampleCodeText: String?)
    {
//        self.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 2000))
        self.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))

        //Set top bar and the challenge's question + code
        let rectangle = view.setTopBar()
        let title = view.setTitle(title: titleText)
        let dismissButton = view.setdismissButton(dismissButtonAction: dismissButtonAction)
        let helpButton = view.setHelpButton(helpButtonAction: helpButtonAction)
        let question = view.setQuestion(questionText: questionText)
        self.code = view.setExampleCode(exampleCodeText: exampleCodeText!, view: self)
        
        // O sizeView é usado para determinar o tamanho da view e da scrollView
//        let height = sizeView!
//        self.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: height)

        self.layer.addSublayer(rectangle)
        self.addSubview(title)
        self.addSubview(dismissButton)
        self.addSubview(helpButton)
        self.addSubview(question)
        self.addSubview(code)
    }
    
    func setLabelUserAnswer(labelText: String)
    {
        let xScale = screenSize.width/widhtiPhoneSE
        let yScale = screenSize.height/heightiPhoneSE
        
        let endOfMainView = code.frame.height + code.frame.origin.y
        
        self.labelCorrectUserAnswer = UILabel(text: "You answered correctly: " + labelText, font: userAnswerFont, fontSize: userAnswerFontSize, aligment: userAnswerAlignment, textColor: UIColor(red:0.28, green:0.64, blue:0.31, alpha:1.0), frame: CGRect(x: userAnswerX, y: endOfMainView, width: userAnswerWidth, height: userAnswerHeight))
        
        // The heightForView function resizes the label
        let heightCorrectAnswer = heightForView(text: self.labelCorrectUserAnswer.text!, font: labelCorrectUserAnswer.font, width: labelCorrectUserAnswer.frame.width)
        self.labelCorrectUserAnswer.frame = CGRect(x: userAnswerX*xScale, y: endOfMainView + 20*yScale, width: userAnswerWidth*xScale, height: heightCorrectAnswer)
        
        self.labelWrongUserAnswer = UILabel(text: "Your answer: " + labelText, font: userAnswerFont, fontSize: userAnswerFontSize, aligment: userAnswerAlignment, textColor: UIColor(red:1.58, green:0.21, blue:0.38, alpha:1.0), frame: CGRect(x: userAnswerX, y: endOfMainView, width: userAnswerWidth, height: userAnswerHeight))
        let heightWrongAnswer = heightForView(text: labelWrongUserAnswer.text!, font: labelWrongUserAnswer.font, width: labelWrongUserAnswer.frame.width)
        self.labelWrongUserAnswer.frame = CGRect(x: userAnswerX*xScale, y: endOfMainView + 20*yScale, width: userAnswerWidth*xScale, height: heightWrongAnswer)
    }
    
    func setCorrectChallengeAnswer(labelText: String)
    {
        let xScale = screenSize.width/widhtiPhoneSE
        let yScale = screenSize.height/heightiPhoneSE
        
        let yPosition = self.labelWrongUserAnswer.frame.origin.y + self.labelWrongUserAnswer.frame.height
        
        self.labelCorrectAnswer = UILabel(text: "Correct answer: " + labelText, font: userAnswerFont, fontSize: userAnswerFontSize, aligment: userAnswerAlignment, textColor: UIColor(red:0.21, green:0.23, blue:0.47, alpha:1.0), frame: CGRect(x: userAnswerX, y: yPosition, width: userAnswerWidth, height: userAnswerHeight))
        let height = heightForView(text: labelCorrectAnswer.text!, font: labelCorrectAnswer.font, width: labelCorrectAnswer.frame.width)
        self.labelCorrectAnswer.frame = CGRect(x: userAnswerX*xScale, y: yPosition + 10*yScale, width: userAnswerWidth*xScale, height: height)
    }
    
    func setLabelExplanation(labelText: String, previousLabel: UILabel)
    {
        
        let xScale = screenSize.width/widhtiPhoneSE
        let yScale = screenSize.height/heightiPhoneSE
        
        let explanationLabelY = previousLabel.frame.origin.y + previousLabel.frame.height
        
        self.labelExplanation = UILabel(text: "Explanation: " + labelText, font: userAnswerFont, fontSize: userAnswerFontSize, aligment: userAnswerAlignment, textColor: UIColor(red:0.21, green:0.23, blue:0.47, alpha:1.0), frame: CGRect(x: userAnswerX,y: explanationLabelY, width: userAnswerWidth, height: 120))
        let height = heightForView(text: labelText, font: labelExplanation.font, width: labelExplanation.frame.width)
        self.labelExplanation.frame = CGRect(x: userAnswerX*xScale, y: explanationLabelY + 10*yScale, width: userAnswerWidth*xScale, height: height)
    }
    
    func setButton(continueButtonAction: Selector) {
        
        let xScale = screenSize.width/widhtiPhoneSE
        let yScale = screenSize.height/heightiPhoneSE
                
        self.buttonContinue = UIButton(image: "continue", frame: CGRect(x: 16*xScale, y: screenSize.height - 80*yScale, width: 288*xScale, height: 46*yScale), target: self)
        self.buttonContinue.addTarget(target, action: continueButtonAction, for: .touchUpInside)
        
        let yPostionLastLabel = labelExplanation.frame.minY
        
        if yPostionLastLabel < 568*yScale{
            buttonContinue.frame.origin = CGPoint(x: 16*xScale, y: screenSize.height - 80*yScale)
            self.sizeView = screenSize.height

        } else {
            buttonContinue.frame.origin = CGPoint(x: 16*xScale, y: yPostionLastLabel + 62*yScale)
            self.sizeView = buttonContinue.frame.minY + 62*yScale
        }
            print("SIZE VIEW: ", sizeView)
        
//            let height = sizeView!
//            self.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: height)
    }
    
//    func setFrameSize()
//    {
//        let height = sizeView!
//        self.frame = CGRect(x: 0, y: 0, width: screenSize.width, height: height)
//    }

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
