//
//  BlankFieldView.swift
//  be-swift
//
//  Created by Isabella Vieira on 08/10/17.
//  Copyright © 2017 Isabella Vieira. All rights reserved.
//

import Foundation
import UIKit

class BlankFieldView: View {
    
    var view = View(frame: CGRect.zero)
    var code: UILabel!
    var blankField: UITextField!
    var sizeView: CGFloat!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init (titleText: String, dismissButtonAction: Selector, helpButtonAction: Selector, questionText: String, exampleCodeText: String?, checkButtonAction: Selector, currentView: UIViewController){
        self.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 2000))
        
        let rectangle = view.setTopBar()
        let title = view.setTitle(title: titleText)
        let dismissButton = view.setdismissButton(dismissButtonAction: dismissButtonAction)
        let helpButton = view.setHelpButton(helpButtonAction: helpButtonAction)
        let question = view.setQuestion(questionText: questionText)
        print("FRAME 3 \(question.frame)")
        code = view.setExempleCode(exampleCodeText: exampleCodeText!, view: self)
        
        self.setBlankField()
        blankField.delegate = currentView as? UITextFieldDelegate
        self.setCheckButton(checkButtonAction: checkButtonAction)
        let height = sizeView!
        self.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: height)
        
        self.layer.addSublayer(rectangle)
        self.addSubview(title)
        self.addSubview(dismissButton)
        self.addSubview(helpButton)
        self.addSubview(question)
        self.addSubview(code)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setBlankField(){
        blankField = UITextField(frame: CGRect(x: 0, y: 0, width: 288, height: 32), font: "SanFranciscoText-Medium", fontSize: 16)
        
        let heightCode = code.frame.height
        let yPostionCode = code.frame.minY
        let distance = heightCode + yPostionCode
        
        let widhtiPhoneSE: CGFloat = 320
        let heightiPhoneSE: CGFloat = 568
        let screenSize = UIScreen.main.bounds
        let xScale = screenSize.width/widhtiPhoneSE
        let yScale = screenSize.height/heightiPhoneSE
        
        blankField.frame.origin = CGPoint(x: 16*xScale, y: distance + 40*yScale)
        
        self.addSubview(blankField)
    }
    
    func setCheckButton(checkButtonAction: Selector){
        let checkButton = UIButton(image: "check", frame: CGRect(x: 0, y: 0, width: 288, height: 46), target: self)
        let yPostionBlankField = blankField.frame.minY
        checkButton.addTarget(target, action: checkButtonAction, for: UIControlEvents.touchUpInside)
        
        let widhtiPhoneSE: CGFloat = 320
        let heightiPhoneSE: CGFloat = 568
        let screenSize = UIScreen.main.bounds
        let xScale = screenSize.width/widhtiPhoneSE
        let yScale = screenSize.height/heightiPhoneSE
        
        if yPostionBlankField < 568*yScale{
            checkButton.frame.origin = CGPoint(x: 16*xScale, y: screenSize.height - 62*yScale)
            sizeView = screenSize.height
        } else {
            checkButton.frame.origin = CGPoint(x: 16*xScale, y: yPostionBlankField + 70*yScale)
            sizeView = checkButton.frame.minY + 62*yScale
        }
        
        self.addSubview(checkButton)
    }
    
}

