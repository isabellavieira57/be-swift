//
//  MultipleChoiceView.swift
//  be-swift
//
//  Created by Isabella Vieira on 08/10/17.
//  Copyright © 2017 Isabella Vieira. All rights reserved.
//

import Foundation
import UIKit

class MultipleChoiceView: View {
    
    let view = View(frame: CGRect.zero)
    
//    let multipleChoiceController: MultipleChoiceController!
    var optionButton1: SSRadioButton!
    var optionButton2: SSRadioButton!
    var optionButton3: SSRadioButton!
    var optionButton4: SSRadioButton!
    var correctAnswer: String!
    var checkButton: UIButton!
    var code: UILabel!
    
    let widhtiPhoneSE: CGFloat = 320
    let heightiPhoneSE: CGFloat = 568
    let screenSize = UIScreen.main.bounds
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor(red:0.96, green:0.96, blue:0.96, alpha:1.0)
        
    }

    convenience init (frame: CGRect, titleText: String, dismissButtonAction: Selector, helpButtonAction: Selector, questionText: String, exampleCodeText: String?, options: Array<String>, correctAnswer: String){
        self.init(frame: frame)
        
        self.correctAnswer = correctAnswer
        
        let rectangle = view.setTopBar()
        let title = view.setTitle(title: titleText)
        let dismissButton = view.setdismissButton(dismissButtonAction: dismissButtonAction)
        let helpButton = view.setHelpButton(helpButtonAction: helpButtonAction)
        let question = view.setQuestion(questionText: questionText)
        //let code = view.setExempleCode(exampleCodeText: exampleCodeText!, view: self)
        code = view.setExempleCode(exampleCodeText: exampleCodeText!, view: self)
        
        self.layer.addSublayer(rectangle)
        self.addSubview(title)
        self.addSubview(dismissButton)
        self.addSubview(helpButton)
        self.addSubview(question)
        self.addSubview(code)
        
        createButtons(options: options)
        setCheckButton()

    }
    
    func createButtons(options: Array<String>)
    {
        let xScale = screenSize.width/widhtiPhoneSE
        let yScale = screenSize.height/heightiPhoneSE
        
        let optionButtonX: CGFloat = 8*xScale
        let optionButtonWidth: CGFloat  = 300*xScale
        let optionButtonHeight: CGFloat  = 57*yScale
        let spaceBetweenButtons: CGFloat  = -6.3*yScale
        
        let endOfMainView = code.frame.height + code.frame.origin.y + 20*yScale
        
        optionButton1 = SSRadioButton(frame: CGRect(x: optionButtonX, y: endOfMainView, width: optionButtonWidth, height: optionButtonHeight))
        optionButton1.optionLabel.text = options[0]
        
        let optionButton2Y = self.optionButton1.frame.origin.y + self.optionButton1.frame.height + spaceBetweenButtons
        
        optionButton2 = SSRadioButton(frame: CGRect(x: optionButtonX, y: optionButton2Y, width: optionButtonWidth, height: optionButtonHeight))
        optionButton2.optionLabel.text = options[1]
        
        let optionButton3Y = self.optionButton2.frame.origin.y + self.optionButton2.frame.height + spaceBetweenButtons
        
        optionButton3 = SSRadioButton(frame: CGRect(x: optionButtonX, y: optionButton3Y, width: optionButtonWidth, height: optionButtonHeight))
        optionButton3.optionLabel.text = options[2]
        
        let optionButton4Y = self.optionButton3.frame.origin.y + self.optionButton3.frame.height + spaceBetweenButtons
        
        optionButton4 = SSRadioButton(frame: CGRect(x: optionButtonX, y: optionButton4Y, width: optionButtonWidth, height: optionButtonHeight))
        optionButton4.optionLabel.text = options[3]
        
        
        self.addSubview(optionButton1)
        self.addSubview(optionButton2)
        self.addSubview(optionButton3)
        self.addSubview(optionButton4)
    }
    
    func setCheckButton()
    {
        let xScale = screenSize.width/widhtiPhoneSE
        let yScale = screenSize.height/heightiPhoneSE
        
        self.checkButton = UIButton(image: "check", frame: CGRect(x: 0, y: 0, width: 288, height: 46), target: self)
        let yPostionOptionButton4 = optionButton4.frame.minY
        
        if yPostionOptionButton4 < 568*yScale{
            checkButton.frame.origin = CGPoint(x: 16*xScale, y: screenSize.height - 80*yScale)
        } else {
            checkButton.frame.origin = CGPoint(x: 16*xScale, y: yPostionOptionButton4 + 70*yScale)
        }
        
        self.addSubview(checkButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
