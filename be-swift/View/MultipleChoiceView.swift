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
    
    var multipleChoiceController: MultipleChoiceController!
    var optionButton1: MultipleChoiceButton!
    var optionButton2: MultipleChoiceButton!
    var optionButton3: MultipleChoiceButton!
    var optionButton4: MultipleChoiceButton!
    var optionCircle1: UIImageView!
    var optionCircle2: UIImageView!
    var optionCircle3: UIImageView!
    var optionCircle4: UIImageView!
    var arraySelectedButtons: Array<UIButton>!
    var userAnswer: String?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//    }
//
//    convenience init(frame: CGRect, options: Array<String>){
//        self.init(frame: frame)
        
        self.backgroundColor = UIColor(red:0.96, green:0.96, blue:0.96, alpha:1.0)

        var options = ["Option 1", "7: operator '>' can't be applied to operrands of type '()' and 'Int'", "7: '>' can't be used on types '()' and 'Int'", "Option 4"]
        
        // Variables to create buttons

        var screenWidth = UIScreen.main.bounds.width
        var screenHeight = UIScreen.main.bounds.height
        
        var optionButtonX: CGFloat = screenWidth*0.02
        var optionButtonWidth: CGFloat  = screenWidth*0.95
        var optionButtonHeight: CGFloat  = screenHeight*0.11
        var spaceBetweenButtons: CGFloat  = -6.5
        var marginToTitle: CGFloat = screenWidth*0.12
        var circleX: CGFloat = screenWidth*0.05 + optionButtonX
        var circleDiameter: CGFloat = screenWidth*0.045
        
        // Create 1st button
        
        optionButton1 = MultipleChoiceButton(image: "optionMultipleChoice", frame: CGRect(x: optionButtonX, y: 0, width: optionButtonWidth, height: optionButtonHeight), target: self.optionButton1, action: #selector(MultipleChoiceView.selectButton(_: )))
//        optionButton1 = UIButton(image: "optionMultipleChoice", frame: CGRect(x: optionButtonX, y: 0, width: optionButtonWidth, height: optionButtonHeight), target: self.optionButton1, action: #selector(multipleChoiceController.didSelectButton(selectedButton: optionButton1)))
        optionButton1.setTitle(options[0], for: .normal)
        optionButton1.titleLabel?.font = UIFont(name: "SanFranciscoText-Medium", size: 16)
        optionButton1.setTitleColor(UIColor(red:0.21, green:0.23, blue:0.47, alpha:1.0), for: .normal)
        optionButton1.contentHorizontalAlignment = .left
        optionButton1.contentEdgeInsets.left = marginToTitle
        optionButton1.contentEdgeInsets.right = 2.5
        optionButton1.setImage(UIImage(named: "selectedOption2"), for: .selected)
        
        optionCircle1 = UIImageView(frame: CGRect(x: circleX, y: optionButton1.frame.origin.y + optionButtonHeight/2.8, width: circleDiameter, height: circleDiameter))
        optionCircle1.image = UIImage(named: "defaultCircle")
        
        // Create 2nd button
        
        var optionButton2Y = self.optionButton1.frame.origin.y + self.optionButton1.frame.height + spaceBetweenButtons
        
        optionButton2 = MultipleChoiceButton(image: "optionMultipleChoice", frame: CGRect(x: optionButtonX, y: optionButton2Y, width: optionButtonWidth, height: optionButtonHeight), target: self.optionButton2, action: #selector(MultipleChoiceView.selectButton(_: )))
        optionButton2.setTitle(options[1], for: .normal)
        optionButton2.titleLabel?.font = UIFont(name: "SanFranciscoText-Medium", size: 16)
        optionButton2.setTitleColor(UIColor(red:0.21, green:0.23, blue:0.47, alpha:1.0), for: .normal)
        optionButton2.contentHorizontalAlignment = .left
        optionButton2.contentEdgeInsets.left = marginToTitle
        optionButton2.contentEdgeInsets.right = 2.5
        optionButton2.setImage(UIImage(named: "selectedOption2"), for: .selected)
        
        optionCircle2 = UIImageView(frame: CGRect(x: circleX, y: optionButton2Y + optionButtonHeight/2.8, width: circleDiameter, height: circleDiameter))
        optionCircle2.image = UIImage(named: "defaultCircle")

        // Create 3rd button
        
        var optionButton3Y = self.optionButton2.frame.origin.y + self.optionButton2.frame.height + spaceBetweenButtons
        
        optionButton3 = MultipleChoiceButton(image: "optionMultipleChoice", frame: CGRect(x: optionButtonX, y: optionButton3Y, width: optionButtonWidth, height: optionButtonHeight), target: self.optionButton3, action: #selector(MultipleChoiceView.selectButton(_: )))
        optionButton3.setTitle(options[2], for: .normal)
        optionButton3.titleLabel?.font = UIFont(name: "SanFranciscoText-Medium", size: 16)
        optionButton3.setTitleColor(UIColor(red:0.21, green:0.23, blue:0.47, alpha:1.0), for: .normal)
        optionButton3.contentHorizontalAlignment = .left
        optionButton3.contentEdgeInsets.left = marginToTitle
        optionButton3.contentEdgeInsets.right = 2.5
        optionButton3.setImage(UIImage(named: "selectedOption2"), for: .selected)

        optionCircle3 = UIImageView(frame: CGRect(x: circleX, y: optionButton3Y + optionButtonHeight/2.8, width: circleDiameter, height: circleDiameter))
        optionCircle3.image = UIImage(named: "defaultCircle")

        // Create 4th button
        
        var optionButton4Y = self.optionButton3.frame.origin.y + self.optionButton3.frame.height + spaceBetweenButtons
        
        optionButton4 = MultipleChoiceButton(image: "optionMultipleChoice", frame: CGRect(x: optionButtonX, y: optionButton4Y, width: optionButtonWidth, height: optionButtonHeight), target: self.optionButton4, action: #selector(MultipleChoiceView.selectButton(_: )))
        optionButton4.setTitle(options[3], for: .normal)
        optionButton4.titleLabel?.font = UIFont(name: "SanFranciscoText-Medium", size: 16)
        optionButton4.setTitleColor(UIColor(red:0.21, green:0.23, blue:0.47, alpha:1.0), for: .normal)
        optionButton4.contentHorizontalAlignment = .left
        optionButton4.contentEdgeInsets.left = marginToTitle
        optionButton4.contentEdgeInsets.right = 2.5
        optionButton4.setImage(UIImage(named: "selectedOption2"), for: .selected)

        optionCircle4 = UIImageView(frame: CGRect(x: circleX, y: optionButton4Y + optionButtonHeight/2.8, width: circleDiameter, height: circleDiameter))
        optionCircle4.image = UIImage(named: "defaultCircle")
        
        optionButton1?.myAlternateButton = [optionButton2!, optionButton3!, optionButton4!]
        optionButton2?.myAlternateButton = [optionButton1!, optionButton3!, optionButton4!]
        optionButton3?.myAlternateButton = [optionButton1!, optionButton2!, optionButton4!]
        optionButton4?.myAlternateButton = [optionButton1!, optionButton2!, optionButton3!]
        
        self.addSubview(optionButton1)
        self.addSubview(optionButton2)
        self.addSubview(optionButton3)
        self.addSubview(optionButton4)
        self.addSubview(optionCircle1)
        self.addSubview(optionCircle2)
        self.addSubview(optionCircle3)
        self.addSubview(optionCircle4)

    }
    
    @objc func selectButton(_ sender: Any) //colocar botão e círculo como parâmetros?
    {
        print("PRESSED BUTTON")
//        for button in [optionButton1, optionButton2, optionButton3, optionButton4]
//        {
//            if button?.isSelected == true
//            {
//                if arraySelectedButtons == nil
//                {
//                    arraySelectedButtons.append(button!)
//                    print(button)
//                } else
//                {
//                    arraySelectedButtons[0].isSelected = false
//                    arraySelectedButtons.remove(at: 0)
//                    arraySelectedButtons.append(button!)
//                }
//
//            }
//        }

//        arraySelectedButtons[0].setBackgroundImage(UIImage(named:"selectedOption2"), for: .)

    }
//
//    func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
//
////        selectButton(_: )
//        super.touchesBegan(touches as! Set<UITouch>, with: event)
//    }
    
        
//        //Deselect other buttons
//        //Change circle color
//        userAnswer = //selectedButton title
//    }
    
//    func checkAnswer(correctAnswer: String) {
//
//        var correctAnswer = correctAnswer
//        var numberOfTries = 0
//
//        if correctAnswer == userAnswer
//        {
//            //Feedback view
//        } else
//        {
//            if numberOfTries < 3
//            {
//                //x symbol
//                //button try again
//                numberOfTries += 1
//            } else
//            {
//                //Feedback view
//                // button try again tomorrow
//            }
//        }
//    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
