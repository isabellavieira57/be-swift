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
//
//    let view = View(frame: CGRect.zero)
    let feedbackView = FeedbackView(frame: CGRect.zero)

    var feedbackTableView: UITableView!
    var buttonYourAnswer: UIButton!
    var buttonCorrectAnswer: UIButton!

    
//    let widhtiPhoneSE: CGFloat = 320
//    let heightiPhoneSE: CGFloat = 568
//    let screenSize = UIScreen.main.bounds
//    let xScale: CGFloat = 0
//    let yScale: CGFloat = 0
//
//    let userAnswerX: CGFloat = 24
//    let userAnswerWidth: CGFloat = 273
//    let userAnswerHeight: CGFloat = 38
//    let userAnswerFont = "SanFranciscoText-Medium"
//    let userAnswerFontSize: CGFloat = 16
//    let userAnswerAlignment = NSTextAlignment.left
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)

        self.backgroundColor = UIColor(red:0.96, green:0.96, blue:0.96, alpha:1.0)
    }

    convenience init (titleText: String, dismissButtonAction: Selector, helpButtonAction: Selector, questionText: String, continueButtonAction: Selector)
    {
//        self.init(frame: frame)
        self.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 2000))
        
        let xScale = screenSize.width/widhtiPhoneSE
        let yScale = screenSize.height/heightiPhoneSE
        
        let rectangle = view.setTopBar()
        let title = view.setTitle(title: titleText)
        let dismissButton = view.setdismissButton(dismissButtonAction: dismissButtonAction)
        let helpButton = view.setHelpButton(helpButtonAction: helpButtonAction)
        let question = view.setQuestion(questionText: questionText)
        
        let height = sizeView!
        self.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: height)
        
        self.layer.addSublayer(rectangle)
        self.addSubview(title)
        self.addSubview(dismissButton)
        self.addSubview(helpButton)
        self.addSubview(question)
    }
    
    func positionUserLabels()
    {
        self.labelCorrectUserAnswer.frame.origin.y = self.feedbackTableView.frame.origin.y + self.feedbackTableView.frame.height + 10*yScale
        
        self.labelWrongUserAnswer.frame.origin.y = self.buttonYourAnswer.frame.origin.y + self.buttonYourAnswer.frame.height + 10*yScale
    }

    func setTableView()
    {
        let sortView = SortView()
        let sortTableView = sortView.sortTableView

        self.feedbackTableView = UITableView(frame: (sortTableView?.frame)!)
        self.feedbackTableView.separatorStyle = .none
        self.feedbackTableView.backgroundColor = UIColor(red:0.96, green:0.96, blue:0.96, alpha:1.0)

        self.addSubview(feedbackTableView)
    }

    func setCompareAnswersButtons(showYourAnswer: Selector, showCorrectAnswer: Selector)
    {
        let sortView = SortView()
        let tableSortView = sortView.sortTableView

        let buttonWidth: CGFloat = 137*xScale
        let buttonHeight: CGFloat = 39*yScale
        let buttonY: CGFloat = (tableSortView?.frame.origin.y)! + (tableSortView?.frame.height)! + 15*yScale

        self.buttonYourAnswer = UIButton(frame: CGRect(x: 16*xScale, y: buttonY, width: buttonWidth, height: buttonHeight))
        self.buttonYourAnswer.setBackgroundImage(UIImage(named: "yourAnswer"), for: .normal)
        self.buttonYourAnswer.addTarget(target, action: showYourAnswer, for: UIControlEvents.touchUpInside)

        self.buttonCorrectAnswer = UIButton(frame: CGRect(x: 167*xScale, y: buttonY, width: buttonWidth, height: buttonHeight))
        self.buttonCorrectAnswer.setBackgroundImage(UIImage(named: "correctAnswer"), for: .normal)
        self.buttonCorrectAnswer.addTarget(target, action: showCorrectAnswer, for: UIControlEvents.touchUpInside)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
