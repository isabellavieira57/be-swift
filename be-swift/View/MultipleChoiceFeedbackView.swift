////
////  MultipleChoiceFeedbackView.swift
////  be-swift
////
////  Created by Ana Müller on 11/13/17.
////  Copyright © 2017 Isabella Vieira. All rights reserved.
////
//
//import Foundation
//import UIKit
//
//class MultipleChoiceFeedbackView: FeedbackView
//{
////    var code: UILabel!
////    var sizeView: CGFloat!
////
////    let feedbackView = FeedbackView(frame: CGRect.zero)
//////    let multChoiceFeedbackController = MultipleChoiceFeedbackViewController()
////
////    override init(frame: CGRect)
////    {
////        super.init(frame: frame)
////
////        self.backgroundColor = UIColor(red:0.96, green:0.96, blue:0.96, alpha:1.0)
////
////    }
////
////    convenience init (titleText: String, dismissButtonAction: Selector, helpButtonAction: Selector, questionText: String, exampleCodeText: String?, endButtonAction: Selector)
////    {
////        self.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 2000))
////
////        let rectangle = view.setTopBar()
////        let title = view.setTitle(title: titleText)
////        let dismissButton = view.setdismissButton(dismissButtonAction: dismissButtonAction)
////        let helpButton = view.setHelpButton(helpButtonAction: helpButtonAction)
////        let question = view.setQuestion(questionText: questionText)
////        code = view.setExempleCode(exampleCodeText: exampleCodeText!, view: self)
////
////        let height = sizeView!
////        self.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: height)
////
////        self.layer.addSublayer(rectangle)
////        self.addSubview(title)
////        self.addSubview(dismissButton)
////        self.addSubview(helpButton)
////        self.addSubview(question)
////        self.addSubview(code)
////    }
////
////    func updateLabelUserAnswer()
////    {
////        let heightCorrectAnswer = heightForView(text: self.feedbackView.labelCorrectUserAnswer.text!, font: self.feedbackView.labelCorrectUserAnswer.font, width: self.feedbackView.labelCorrectUserAnswer.frame.width)
////        self.feedbackView.labelCorrectUserAnswer.frame = CGRect(x: 24*xScale, y: 238*yScale, width: 273*xScale, height: heightCorrectAnswer)
////
////        let heightWrongAnswer = heightForView(text: self.feedbackView.labelWrongUserAnswer.text!, font: self.feedbackView.labelWrongUserAnswer.font, width: self.feedbackView.labelCorrectUserAnswer.frame.width)
////        self.feedbackView.labelWrongUserAnswer.frame = CGRect(x: 24*xScale, y: 238*yScale, width: 273*xScale, height: heightWrongAnswer)
////
////
////
////
////    }
////
////    override func heightForView(text:String, font:UIFont, width:CGFloat) -> CGFloat
////    {
////        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
////        label.numberOfLines = 0
////        label.lineBreakMode = NSLineBreakMode.byWordWrapping
////        label.font = font
////        label.text = text
////        label.sizeToFit()
////
////        return label.frame.height
////    }
////
////    required init?(coder aDecoder: NSCoder) {
////        fatalError("init(coder:) has not been implemented")
////    }
//    
//}

