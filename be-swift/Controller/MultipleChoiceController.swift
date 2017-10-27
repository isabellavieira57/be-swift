//
//  MultipleChoiceController.swift
//  be-swift
//
//  Created by Ana Müller on 10/23/17.
//  Copyright © 2017 Isabella Vieira. All rights reserved.
//


import UIKit

class MultipleChoiceController: UIViewController, SSRadioButtonControllerDelegate
{
    
    var multipleChoiceView: MultipleChoiceView!
    var radioButtonController: SSRadioButtonsController?
    var userAnswer = ""
    var correctAnswer = "Option 2"
    var selectedButton: SSRadioButton?

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        multipleChoiceView = MultipleChoiceView()
        
        self.view.addSubview(multipleChoiceView)
        self.view = self.multipleChoiceView

        radioButtonController = SSRadioButtonsController(buttons: multipleChoiceView.optionButton1, multipleChoiceView.optionButton2, multipleChoiceView.optionButton3, multipleChoiceView.optionButton4)
        radioButtonController!.delegate = self
        radioButtonController!.shouldLetDeSelect = true
        
//        multipleChoiceView.checkButton.addTarget(self, action: #selector(checkAnswer), for: .touchUpInside)
    }
    
    func didSelectButton(selectedButton: SSRadioButton?)
    {
        NSLog(" \(selectedButton)" )
        self.selectedButton = selectedButton
    }
    
    func findUserAnswer(button: SSRadioButton) {
        userAnswer = (button.optionLabel.text)!
        print(userAnswer)
    }
    
    @objc func checkAnswer()
    {
        if selectedButton == nil
        {
            //message: please select an option
        } else
        {
            multipleChoiceView.optionButton1.isUserInteractionEnabled = false
            multipleChoiceView.optionButton2.isUserInteractionEnabled = false
            multipleChoiceView.optionButton3.isUserInteractionEnabled = false
            multipleChoiceView.optionButton4.isUserInteractionEnabled = false
            
            findUserAnswer(button: self.selectedButton!)
            
            if userAnswer == correctAnswer
            {
                //feedbackView with message "You answered correctly..."
            } else
            {
                //remove 'Check' button and add 'Try Again' button
                self.selectedButton?.setBackgroundImage(UIImage(named: "wrongOption"), for: .selected)
            }
        }
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
}
