//
//  SortFeedbackView.swift
//  be-swift
//
//  Created by Ana Müller on 11/10/17.
//  Copyright © 2017 Isabella Vieira. All rights reserved.
//
import Foundation
import UIKit

class SortFeedbackView: FeedbackView
{
    
    //    var sizeView: CGFloat!
    
    let feedbackView = FeedbackView(frame: CGRect.zero)
    
    var feedbackTableView: UITableView!
    var buttonYourAnswer: UIButton!
    var buttonCorrectAnswer: UIButton!
    var tableViewFrame: CGRect!
    var tableViewCode: Array<String>!
    var sortView = SortView()
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor(red:0.96, green:0.96, blue:0.96, alpha:1.0)
    }
    
//    convenience init (titleText: String, dismissButtonAction: Selector, helpButtonAction: Selector, questionText: String, options: Array<String>){
    convenience init (questionText: String, options: Array<String>){
        self.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        
        self.tableViewCode = options
        
//        let rectangle = view.setTopBar()
//        let title = view.setTitle(title: titleText)
//        let dismissButton = view.setdismissButton(dismissButtonAction: dismissButtonAction)
//        let helpButton = view.setHelpButton(helpButtonAction: helpButtonAction)
        let question = view.setQuestion(questionText: questionText)
        
        //        let height = sizeView!
        //        self.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: height)
        
//        self.layer.addSublayer(rectangle)
//        self.addSubview(title)
//        self.addSubview(dismissButton)
//        self.addSubview(helpButton)
        self.addSubview(question)
    }
    
    func setSortUserLabels(){
        let widhtiPhoneSE: CGFloat = 320
        let heightiPhoneSE: CGFloat = 568
        let screenSize = UIScreen.main.bounds
        let xScale = screenSize.width/widhtiPhoneSE
        let yScale = screenSize.height/heightiPhoneSE
        
        let labelUserAnswerY = self.feedbackTableView.frame.origin.y/yScale + self.feedbackTableView.frame.height/yScale + 10
        
        self.labelCorrectUserAnswer = UILabel(text: "You got it! Your answer is correct!", font: self.userAnswerFont, fontSize: self.userAnswerFontSize, aligment: self.userAnswerAlignment, textColor: UIColor(red:0.28, green:0.64, blue:0.31, alpha:1.0), frame: CGRect(x: self.userAnswerX, y: labelUserAnswerY, width: self.userAnswerWidth, height: self.userAnswerHeight))
        
        self.labelCorrectUserAnswer = UILabel(text: "You got it! Your answer is correct!", font: self.userAnswerFont, fontSize: self.userAnswerFontSize, aligment: self.userAnswerAlignment, textColor: UIColor(red:0.28, green:0.64, blue:0.31, alpha:1.0), frame: CGRect(x: self.userAnswerX, y: labelUserAnswerY, width: self.userAnswerWidth, height: self.userAnswerHeight))

        self.labelWrongUserAnswer = UILabel(text: "That's not it! Compare the answers with the buttons above.", font: self.userAnswerFont, fontSize: self.userAnswerFontSize, aligment: self.userAnswerAlignment, textColor: UIColor(red:1.58, green:0.21, blue:0.38, alpha:1.0), frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        self.labelWrongUserAnswer.frame = CGRect (x: self.userAnswerX*xScale, y: labelUserAnswerY*yScale, width: self.userAnswerWidth*xScale, height: self.userAnswerHeight*1.4*yScale)
        
        print("TESTE!!!")
        print(self.feedbackTableView.frame.origin.y)
        print(self.feedbackTableView.frame.height)
        print(self.feedbackTableView.frame.origin.y + self.feedbackTableView.frame.height)
        
    }
    
    func getTableViewFrame(tableViewFrame: CGRect)
    {
        self.tableViewFrame = tableViewFrame
    }
    
    func setTableView()
    {
        let xScale = screenSize.width/widhtiPhoneSE
        let yScale = screenSize.height/heightiPhoneSE
        
        let numberOfLines = self.tableViewCode.count
        
        let endOfMainView = self.view.question.frame.origin.y + self.view.question.frame.height + 10*yScale
        
        self.feedbackTableView = UITableView(frame: CGRect(x: 5*xScale, y: endOfMainView, width: 310*xScale, height: sortView.tableRowHeight * CGFloat(numberOfLines) * yScale))
        self.feedbackTableView.separatorStyle = .none
        self.feedbackTableView.backgroundColor = UIColor(red:0.96, green:0.96, blue:0.96, alpha:1.0)
    }
    
    func setCompareAnswersButtons(showYourAnswer: Selector, showCorrectAnswer: Selector)
    {
        let yScale = screenSize.height/heightiPhoneSE
        
        let buttonWidth: CGFloat = 137
        let buttonHeight: CGFloat = 39
        let buttonY: CGFloat = self.feedbackTableView.frame.origin.y/yScale + self.feedbackTableView.frame.height/yScale + 15
        
        self.buttonYourAnswer = UIButton(image: "yourAnswerBold", frame: CGRect(x: 16, y: buttonY, width: buttonWidth, height: buttonHeight), target: self)
        self.buttonYourAnswer.addTarget(target, action: showYourAnswer, for: UIControlEvents.touchUpInside)
        
        self.buttonCorrectAnswer = UIButton(image: "correctAnswer", frame: CGRect(x: 167, y: buttonY, width: buttonWidth, height: buttonHeight), target: self)
        self.buttonCorrectAnswer.addTarget(target, action: showCorrectAnswer, for: UIControlEvents.touchUpInside)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
