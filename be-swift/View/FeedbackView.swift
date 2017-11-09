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
    
    var userAnswerLabel:UILabel!
    var explanationLabel: UILabel!
    var endButton: UIButton!
    var correctAnswerSortTable: UITableView!
    var userAnswerSortButton: UIButton!
    var correctAnswerSortButton: UIButton!
    
    let view = View(frame: CGRect.zero)
    
    let widhtiPhoneSE: CGFloat = 320
    let heightiPhoneSE: CGFloat = 568
    let screenSize = UIScreen.main.bounds
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor(red:0.96, green:0.96, blue:0.96, alpha:1.0)
        
    }
    
    convenience init (frame: CGRect, titleText: String, dismissButtonAction: Selector, helpButtonAction: Selector, questionText: String, exampleCodeText: String?, options: Array<String>, correctAnswer: Array<String>)
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
        
        setLabelUserAnswer()
        setLabelExplanation()
        setButton()
        
    }
    
    func setLabelUserAnswer()
    {
        
        let xScale = screenSize.width/widhtiPhoneSE
        let yScale = screenSize.height/heightiPhoneSE
        
        self.userAnswerLabel = UILabel(text: "", font: "SanFranciscoText-Medium", fontSize: 16, aligment: .left, textColor: UIColor(red:0.21, green:0.23, blue:0.47, alpha:1.0), frame: CGRect(x: 24*xScale,y: 223*yScale, width: 273*xScale, height: 38*yScale))
        self.userAnswerLabel.lineBreakMode = .byWordWrapping
        self.userAnswerLabel.numberOfLines = 3
        //resizing
        
        self.addSubview(userAnswerLabel)
    }
    
    func setLabelExplanation()
    {
        
        let xScale = screenSize.width/widhtiPhoneSE
        let yScale = screenSize.height/heightiPhoneSE
        
        let explanationLabelY = self.userAnswerLabel.frame.origin.y + self.userAnswerLabel.frame.height + 10
        
        self.explanationLabel = UILabel(text: "", font: "SanFranciscoText-Medium", fontSize: 16, aligment: .left, textColor: UIColor(red:0.21, green:0.23, blue:0.47, alpha:1.0), frame: CGRect(x: 24*xScale,y: explanationLabelY, width: 273*xScale, height: 120*yScale))
        self.explanationLabel.lineBreakMode = .byWordWrapping
        self.explanationLabel.numberOfLines = 20
    //resizing
        
        self.addSubview(explanationLabel)
    }
    
    func setButton() {
        
        let xScale = screenSize.width/widhtiPhoneSE
        let yScale = screenSize.height/heightiPhoneSE
        
        self.endButton = UIButton(image: "continue", frame: CGRect(x: 0, y: 0, width: 288, height: 46), target: self)
        let yPostionLastLabel = explanationLabel.frame.minY
        
        if yPostionLastLabel < 568*yScale{
            endButton.frame.origin = CGPoint(x: 16*xScale, y: screenSize.height - 80*yScale)
        } else {
            endButton.frame.origin = CGPoint(x: 16*xScale, y: yPostionLastLabel + 70*yScale)
        }
        
        self.addSubview(endButton)
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
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
}
