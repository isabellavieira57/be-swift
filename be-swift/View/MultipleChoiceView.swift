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
    
    var view = View(frame: CGRect.zero)
    
    var multipleChoiceController: MultipleChoiceController!
    var optionButton1: SSRadioButton!
    var optionButton2: SSRadioButton!
    var optionButton3: SSRadioButton!
    var optionButton4: SSRadioButton!
    var userAnswer: String?
//    var optionsArray: Array<String>
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor(red:0.96, green:0.96, blue:0.96, alpha:1.0)
        
        var options = ["Option 1", "Option 2", "Option 3", "Option 4"]
        
        createButtons(options: options)
        
    }

    convenience init (frame: CGRect, titleText: String, dismissButtonAction: Selector, helpButtonAction: Selector, questionText: String, exampleCodeText: String?){
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
    }
    
    func createButtons(options: Array<String>)
    {
        var screenWidth = UIScreen.main.bounds.width
        var screenHeight = UIScreen.main.bounds.height
        var optionButtonX: CGFloat = screenWidth*0.02
        var optionButtonWidth: CGFloat  = screenWidth*0.95
        var optionButtonHeight: CGFloat  = screenHeight*0.1
        var spaceBetweenButtons: CGFloat  = -6.5
        
        optionButton1 = SSRadioButton(frame: CGRect(x: optionButtonX, y: 0, width: optionButtonWidth, height: optionButtonHeight))
        optionButton1.optionLabel.text = options[0]
        
        var optionButton2Y = self.optionButton1.frame.origin.y + self.optionButton1.frame.height + spaceBetweenButtons
        
        optionButton2 = SSRadioButton(frame: CGRect(x: optionButtonX, y: optionButton2Y, width: optionButtonWidth, height: optionButtonHeight))
        optionButton2.optionLabel.text = options[1]
        
        var optionButton3Y = self.optionButton2.frame.origin.y + self.optionButton2.frame.height + spaceBetweenButtons
        
        optionButton3 = SSRadioButton(frame: CGRect(x: optionButtonX, y: optionButton3Y, width: optionButtonWidth, height: optionButtonHeight))
        optionButton3.optionLabel.text = options[2]
        
        var optionButton4Y = self.optionButton3.frame.origin.y + self.optionButton3.frame.height + spaceBetweenButtons
        
        optionButton4 = SSRadioButton(frame: CGRect(x: optionButtonX, y: optionButton4Y, width: optionButtonWidth, height: optionButtonHeight))
        optionButton4.optionLabel.text = options[3]
        
        
        self.addSubview(optionButton1)
        self.addSubview(optionButton2)
        self.addSubview(optionButton3)
        self.addSubview(optionButton4)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
