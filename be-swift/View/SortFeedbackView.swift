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
//    override init(frame: CGRect)
//    {
//        super.init(frame: frame)
//
//        self.backgroundColor = UIColor(red:0.96, green:0.96, blue:0.96, alpha:1.0)
//    }
//
////    convenience init (frame: CGRect, titleText: String, dismissButtonAction: Selector, helpButtonAction: Selector, questionText: String, exampleCodeText: String?, options: Array<String>, correctAnswer: Array<String>)
////    {
////        self.init(frame: frame)
////    }
//
//    func setTableView()
//    {
//        let xScale = screenSize.width/widhtiPhoneSE
//        let yScale = screenSize.height/heightiPhoneSE
//
//        let sortView = SortView()
//        let tableSortView = sortView.sortTableView
//
//        self.sortTableCorrectAnswer = UITableView(frame: (tableSortView?.frame)!)
//        self.sortTableCorrectAnswer.separatorStyle = .none
//        self.sortTableCorrectAnswer.backgroundColor = UIColor(red:0.96, green:0.96, blue:0.96, alpha:1.0)
//
//        self.addSubview(sortTableCorrectAnswer)
//    }
//
//    func setSortAnswerButtons()
//    {
//        let xScale = screenSize.width/widhtiPhoneSE
//        let yScale = screenSize.height/heightiPhoneSE
//
//        let sortView = SortView()
//        let tableSortView = sortView.sortTableView
//
//        let buttonWidth: CGFloat = 137*xScale
//        let buttonHeight: CGFloat = 39*yScale
//        let buttonY: CGFloat = (tableSortView?.frame.origin.y)! + (tableSortView?.frame.height)! + 15*yScale
//
//        self.buttonUserAnswerSort = UIButton(frame: CGRect(x: 16*xScale, y: buttonY, width: buttonWidth, height: buttonHeight))
//        self.buttonUserAnswerSort.setBackgroundImage(UIImage(named: "yourAnswer"), for: .normal)
//
//        self.buttonCorrectAnswerSort = UIButton(frame: CGRect(x: 167*xScale, y: buttonY, width: buttonWidth, height: buttonHeight))
//        self.buttonCorrectAnswerSort.setBackgroundImage(UIImage(named: "correctAnswer"), for: .normal)
//
//        self.addSubview(buttonUserAnswerSort)
//        self.addSubview(buttonCorrectAnswerSort)
//    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
