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
    var correctAnswer = ""
    var selectedButton: UIButton?

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        multipleChoiceView = MultipleChoiceView()
        
        self.view.addSubview(multipleChoiceView)
        self.view = self.multipleChoiceView

        radioButtonController = SSRadioButtonsController(buttons: multipleChoiceView.optionButton1, multipleChoiceView.optionButton2, multipleChoiceView.optionButton3, multipleChoiceView.optionButton4)
        radioButtonController!.delegate = self
        radioButtonController!.shouldLetDeSelect = true
        
//        multipleChoiceView.buttonCheck.addTarget(self, action: #selector(self.checkAnswer(_: (Any).self, button: selectedButton!, userAnswer: userAnswer, correctAnswer: correctAnswer)), for: .touchUpInside)

    }
    
    func didSelectButton(selectedButton: UIButton?)
    {
        NSLog(" \(selectedButton)" )
    }
    
    func findUserAnswer() {
        for button in [multipleChoiceView.optionButton1, multipleChoiceView.optionButton2, multipleChoiceView.optionButton3, multipleChoiceView.optionButton4]
        {
            if button?.isSelected == true
            {
                userAnswer = (button?.optionLabel.text)!
            }
        }
    }
    
    func checkAnswer(_ sender: Any, button: UIButton, correctAnswer: String)
    {
        radioButtonController!.shouldLetDeSelect = false

        findUserAnswer()
        
        if userAnswer == correctAnswer
        {
            //feedbackView with message "You answered correctly..."
        } else
        {
            //remove 'Check' button and add 'Try Again'
            button.setBackgroundImage(UIImage(named: "wrongOption"), for: .selected)
        }
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
}
