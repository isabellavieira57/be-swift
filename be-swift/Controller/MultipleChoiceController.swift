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
    var correctAnswer: String!
    var selectedButton: SSRadioButton?
    var challenge: Challenge!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        multipleChoiceView = MultipleChoiceView(frame: CGRect.zero, titleText: "Exemplo", dismissButtonAction: #selector(dismissButton), helpButtonAction: #selector(helpButton), questionText: "Pergunta? \n hehe", exampleCodeText: "let mySize = Size()\n print(mySize.height)\n struct Size {\n \t var height = 10}", options: ["Option 1", "Option 2", "Option 3", "Option 4"], correctAnswer: ["Option2"])
//        multipleChoiceView = MultipleChoiceView(frame: CGRect.zero, titleText: "", dismissButtonAction: #selector(dismissButton), helpButtonAction: #selector(helpButton), questionText: challenge.question, exampleCodeText: "", options: challenge.options, correctAnswer: challenge.correctAnswer)
        
        self.view.addSubview(multipleChoiceView)
        self.view = self.multipleChoiceView
        
        radioButtonController = SSRadioButtonsController(buttons: multipleChoiceView.optionButton1, multipleChoiceView.optionButton2, multipleChoiceView.optionButton3, multipleChoiceView.optionButton4)
        radioButtonController!.delegate = self
        radioButtonController!.shouldLetDeSelect = true
        
        self.correctAnswer = multipleChoiceView.correctAnswer
        
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
    
    @objc func dismissButton()
    {
        //        dismiss(animated: true, completion: nil)
        //        let controller = SortViewController()
        //        present(controller, animated: true, completion: nil)
    }
    
    @objc func helpButton()
    {
        //        let webView = WebDocumentationViewController()
        //        present(webView, animated: false, completion: nil)
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
}

