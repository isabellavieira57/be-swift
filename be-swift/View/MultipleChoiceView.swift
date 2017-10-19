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
    
    var optionButton1: UIButton!
    var optionButton2: UIButton!
    var optionButton3: UIButton!
    var optionButton4: UIButton!
    var userAnswer: String?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//    }
//
//    convenience init(frame: CGRect, options: Array<String>){
//        self.init(frame: frame)
        
        var options = ["A", "B", "C", "D"]

        self.backgroundColor = UIColor.lightGray
        
        var screenWidth = UIScreen.main.bounds.width
        var screenHeight = UIScreen.main.bounds.height
        
        
//        optionButton1 = UIButton(frame: button1Frame)
//        optionButton1.backgroundColor = UIColor.white
//        optionButton1.setTitle(options[0], for: .normal)
//        optionButton1.titleLabel?.textColor = UIColor.black

        
        // Create buttons (originY + frame + set button)
        
        var spaceBetweenButtons: CGFloat = 8
        
        var button1Frame = CGRect(x: 16.5, y: 10, width: 288, height: screenHeight*0.09)
        
        optionButton1 = UIButton(image: "optionMultChoice", frame: button1Frame, target: self.optionButton1, action: #selector(MultipleChoiceView.selectButton(_: )))
        optionButton1.setTitle(options[0], for: .normal)

        var secondButtonOrigin = self.optionButton1.frame.origin.y + self.optionButton1.frame.height + spaceBetweenButtons
        
        var button2Frame = CGRect(x: optionButton1.frame.origin.x, y: secondButtonOrigin, width: optionButton1.frame.width, height: optionButton1.frame.height)
        
        optionButton2 = UIButton(image: "optionMultChoice", frame: button2Frame, target: self.optionButton1, action: #selector(MultipleChoiceView.selectButton(_: )))
        optionButton2.setTitle(options[1], for: .normal)
        
        var thirdButtonOrigin = self.optionButton2.frame.origin.y + self.optionButton2.frame.height + spaceBetweenButtons
        
        var button3Frame = CGRect(x: optionButton1.frame.origin.x, y: thirdButtonOrigin, width: optionButton1.frame.width, height: optionButton1.frame.height)

        optionButton3 = UIButton(image: "optionMultChoice", frame: button3Frame, target: self.optionButton1, action: #selector(MultipleChoiceView.selectButton(_: )))
        optionButton3.setTitle(options[2], for: .normal)

        var fourthButtonOrigin = self.optionButton3.frame.origin.y + self.optionButton3.frame.height + spaceBetweenButtons
        
        var button4Frame = CGRect(x: optionButton1.frame.origin.x, y: fourthButtonOrigin, width: optionButton1.frame.width, height: optionButton1.frame.height)
        
        optionButton4 = UIButton(image: "optionMultChoice", frame: button4Frame, target: self.optionButton1, action: #selector(MultipleChoiceView.selectButton(_: )))
        optionButton4.setTitle(options[3], for: .normal)
        
        
        self.addSubview(optionButton1)
        self.addSubview(optionButton2)
        self.addSubview(optionButton3)
        self.addSubview(optionButton4)
    }
    
    @objc func selectButton(_ sender: Any) {
//        //Deselect other buttons
//        //Change button color
//        userAnswer = //selectedButton title
    }
    
    func checkAnswer(correctAnswer: String) {
       
        var correctAnswer = correctAnswer
        var numberOfTries = 0
        
        if correctAnswer == userAnswer
        {
            //Feedback view
        } else
        {
            if numberOfTries < 3
            {
                //x symbol
                //button try again
                numberOfTries += 1
            } else
            {
                //Feedback view
                // button try again tomorrow
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
