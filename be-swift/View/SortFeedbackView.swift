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
    
    func setTableView()
    {
        let xScale = screenSize.width/widhtiPhoneSE
        let yScale = screenSize.height/heightiPhoneSE
        
        let sortView = SortView()
        let tableSortView = sortView.sortTableView
        
        self.correctAnswerSortTable = UITableView(frame: (tableSortView?.frame)!)
        self.correctAnswerSortTable.separatorStyle = .none
        self.correctAnswerSortTable.backgroundColor = UIColor(red:0.96, green:0.96, blue:0.96, alpha:1.0)
        
        self.addSubview(correctAnswerSortTable)
    }
    
    func setSortAnswerButtons()
    {
        let xScale = screenSize.width/widhtiPhoneSE
        let yScale = screenSize.height/heightiPhoneSE
        
        let sortView = SortView()
        let tableSortView = sortView.sortTableView
        
        let buttonWidth: CGFloat = 137*xScale
        let buttonHeight: CGFloat = 39*yScale
        let buttonY: CGFloat = (tableSortView?.frame.origin.y)! + (tableSortView?.frame.height)! + 15*yScale
        
        self.userAnswerSortButton = UIButton(frame: CGRect(x: 16*xScale, y: buttonY, width: buttonWidth, height: buttonHeight))
        self.userAnswerSortButton.setBackgroundImage(UIImage(named: "yourAnswer"), for: .normal)
        
        self.correctAnswerSortButton = UIButton(frame: CGRect(x: 167*xScale, y: buttonY, width: buttonWidth, height: buttonHeight))
        self.correctAnswerSortButton.setBackgroundImage(UIImage(named: "correctAnswer"), for: .normal)
        
        self.addSubview(userAnswerSortButton)
        self.addSubview(correctAnswerSortButton)
    }
    
}
