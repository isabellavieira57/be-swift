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
    var starsEarned: Int!
    var timeSolved: Int!
    var starsIcon: UIImageView!
    var timeIcon: UIImageView!
    var timeLabel: UILabel!
    
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
  
//    convenience init (titleText: String, dismissButtonAction: Selector, helpButtonAction: Selector, questionText: String, exampleCodeText: String?){
    convenience init (questionText: String, exampleCodeText: String?, starsEarned: Int, timeSolved: Double){
//        self.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 2000))
        self.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        
        self.starsEarned = starsEarned
        self.timeSolved = Int(timeSolved)
        
        //Set top bar and the challenge's question + code
//        let rectangle = view.setTopBar()
//        let title = view.setTitle(title: titleText)
//        let dismissButton = view.setdismissButton(dismissButtonAction: dismissButtonAction)
//        let helpButton = view.setHelpButton(helpButtonAction: helpButtonAction)
        let question = view.setQuestion(questionText: questionText)
        self.code = view.setExampleCode(exampleCodeText: exampleCodeText!, view: self)
        
        // O sizeView é usado para determinar o tamanho da view e da scrollView
//        let height = sizeView!
//        self.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: height)

//        self.layer.addSublayer(rectangle)
//        self.addSubview(title)
//        self.addSubview(dismissButton)
//        self.addSubview(helpButton)
        self.addSubview(question)
        self.addSubview(code)
        
        setPerformanceIcons(previousElement: code)
    }
    
    func setPerformanceIcons(previousElement: AnyObject)
    {
        let xScale = screenSize.width/widhtiPhoneSE
        let yScale = screenSize.height/heightiPhoneSE
        
        let iconY = previousElement.frame.height + previousElement.frame.origin.y + 25*yScale
//        let iconY = code.frame.height + code.frame.origin.y + 25*yScale
        let iconHeight: CGFloat = 21
        
        self.starsIcon = UIImageView(frame: CGRect(x: screenSize.width/2 - 36*xScale, y: iconY, width: 72*xScale, height: iconHeight*yScale))
        
        var starsImage: String!
        switch self.starsEarned {
        case 1:
            starsImage = "oneStarFb"
        case 2:
            starsImage = "twoStarFb"
        case 3:
            starsImage = "threeStarFb"
        default:
            starsImage = "noStarFb"
        }
        
        self.starsIcon.image = UIImage(named: starsImage)
        
        self.timeIcon = UIImageView(frame: CGRect(x: 277*xScale, y: iconY, width: 21*xScale, height: iconHeight*yScale))
        timeIcon.image = UIImage(named: "clockIcon")
        
        self.timeLabel = UILabel(text: String(timeSolved) + " s", font: userAnswerFont, fontSize: userAnswerFontSize, aligment: NSTextAlignment.right, textColor: UIColor(red:0.56, green:0.55, blue:0.55, alpha:1.0), frame: CGRect(x: 217, y: iconY/yScale, width: 54, height: iconHeight))
        
//        self.addSubview(starsIcon)
    }
    
    func setLabelUserAnswer(labelText: String)
    {
        let xScale = screenSize.width/widhtiPhoneSE
        let yScale = screenSize.height/heightiPhoneSE
        
        let userLabelY = self.starsIcon.frame.height + self.starsIcon.frame.origin.y + 12*yScale
        
        self.labelCorrectUserAnswer = UILabel(text: "You answered correctly: " + labelText, font: userAnswerFont, fontSize: userAnswerFontSize, aligment: userAnswerAlignment, textColor: UIColor(red:0.30, green:0.75, blue:0.34, alpha:1.0), frame: CGRect(x: userAnswerX, y: userLabelY/yScale, width: userAnswerWidth, height: userAnswerHeight))
        
        // The heightForView function resizes the label
        let heightCorrectAnswer = heightForView(text: self.labelCorrectUserAnswer.text!, font: labelCorrectUserAnswer.font, width: labelCorrectUserAnswer.frame.width)
        self.labelCorrectUserAnswer.frame = CGRect(x: userAnswerX*xScale, y: userLabelY, width: userAnswerWidth*xScale, height: heightCorrectAnswer)
        
        self.labelWrongUserAnswer = UILabel(text: "Your answer: " + labelText, font: userAnswerFont, fontSize: userAnswerFontSize, aligment: userAnswerAlignment, textColor: UIColor(red:0.92, green:0.13, blue:0.22, alpha:1.0), frame: CGRect(x: userAnswerX, y: userLabelY/yScale, width: userAnswerWidth, height: userAnswerHeight))
        let heightWrongAnswer = heightForView(text: labelWrongUserAnswer.text!, font: labelWrongUserAnswer.font, width: labelWrongUserAnswer.frame.width)
        self.labelWrongUserAnswer.frame = CGRect(x: userAnswerX*xScale, y: userLabelY, width: userAnswerWidth*xScale, height: heightWrongAnswer)
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
    
    func setLabelExplanation(labelText: String, previousLabel: UILabel){
        
        let xScale = screenSize.width/widhtiPhoneSE
        let yScale = screenSize.height/heightiPhoneSE
        
        let explanationLabelY = previousLabel.frame.origin.y + previousLabel.frame.height
        
        labelExplanation = UILabel(text: "Explanation: " + labelText, font: userAnswerFont, fontSize: userAnswerFontSize, aligment: userAnswerAlignment, textColor: UIColor(red:0.21, green:0.23, blue:0.47, alpha:1.0), frame: CGRect(x: userAnswerX,y: explanationLabelY, width: userAnswerWidth, height: 120))
        let height = heightForView(text: labelText, font: labelExplanation.font, width: labelExplanation.frame.width)
        labelExplanation.frame = CGRect(x: labelExplanation.frame.origin.x, y: explanationLabelY + 10*yScale, width: labelExplanation.frame.width, height: height + 50*yScale)
    }
    
    func setButton(continueButtonAction: Selector) {
        
        let xScale = screenSize.width/widhtiPhoneSE
        let yScale = screenSize.height/heightiPhoneSE
  
        self.buttonContinue = UIButton(image: "continue", frame: CGRect(x: 0, y: 0, width: 288, height: 46), target: self)
        self.buttonContinue.addTarget(target, action: continueButtonAction, for: .touchUpInside)
        
        let yPostionLastLabel = labelExplanation.frame.minY
        let heightLastLabel = labelExplanation.frame.height
        let distance = yPostionLastLabel + heightLastLabel
        
        if distance < 510*yScale{
            buttonContinue.frame.origin = CGPoint(x: 16*xScale, y: screenSize.height - 140*yScale)
            self.sizeView = screenSize.height

        } else {
            buttonContinue.frame.origin = CGPoint(x: 16*xScale, y: distance + 70*yScale)
            self.sizeView = buttonContinue.frame.minY + 140*yScale
        }
        print("HAAAA")
        print("SIZE VIEW: ", sizeView)
        
    }
    
//    func setFrameSize()
//    {
//        let height = sizeView!
//        self.frame = CGRect(x: 0, y: 0, width: screenSize.width, height: height)
//    }
    
//    func heightForView(text:String, font:UIFont, width:CGFloat) -> CGFloat{
//        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
//        label.numberOfLines = 0
//        label.lineBreakMode = NSLineBreakMode.byWordWrapping
//        label.font = font
//        label.text = text
//        label.sizeToFit()
//
//        return label.frame.height
//    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
}
