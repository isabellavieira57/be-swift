//
//  MultipleChoiceController.swift
//  be-swift
//
//  Created by Ana Müller on 10/23/17.
//  Copyright © 2017 Isabella Vieira. All rights reserved.
//


import UIKit
import GameplayKit

class MultipleChoiceController: UIViewController, SSRadioButtonControllerDelegate {
    
    var multipleChoiceView: MultipleChoiceView!
    var radioButtonController: SSRadioButtonsController?
    var userAnswer = ""
    var answerIsRight: Bool!
    var selectedButton: SSRadioButton?
    var challenge: Challenge!
    var scrollView: UIScrollView!
    var correctAnswer: String!
    var options: Array<String>!
    var numberOfTries = 0
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        self.correctAnswer = self.challenge.correctAnswer[0] as! String
        self.options = self.challenge.options as! Array<String>
        
        multipleChoiceView = MultipleChoiceView(titleText: self.challenge.tags[0] as! String, dismissButtonAction: #selector(dismissButton), helpButtonAction: #selector(helpButton), checkButtonAction: #selector(checkAnswer), questionText: self.challenge.question, exampleCodeText: self.challenge.exampleCode, options: self.options, correctAnswer: self.correctAnswer)
        
        //Set scrollView
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        scrollView.contentSize = CGSize(width: self.view.frame.size.width, height: multipleChoiceView.frame.height)
        
        self.view.addSubview(scrollView)
        scrollView.addSubview(multipleChoiceView)

        setRadioButtonController()
    }
    
    func setRadioButtonController()
    {
        radioButtonController = SSRadioButtonsController(buttons: multipleChoiceView.optionButton1, multipleChoiceView.optionButton2, multipleChoiceView.optionButton3, multipleChoiceView.optionButton4)
        radioButtonController!.delegate = self
        radioButtonController!.shouldLetDeSelect = true
    }
    
    func didSelectButton(selectedButton: SSRadioButton?)
    {
        NSLog(" \(selectedButton)" )
        self.selectedButton = selectedButton
        print("SELECTED BUTTON: ", self.selectedButton?.optionLabel.text)
    }
    
    func findUserAnswer(button: SSRadioButton)
    {
        self.userAnswer = (button.optionLabel.text)!
        print(userAnswer)
    }
    
    @objc func checkAnswer()
    {
        if selectedButton == nil
        {
            //add message: please select an option
        } else
        {
            multipleChoiceView.optionButton1.isUserInteractionEnabled = false
            multipleChoiceView.optionButton2.isUserInteractionEnabled = false
            multipleChoiceView.optionButton3.isUserInteractionEnabled = false
            multipleChoiceView.optionButton4.isUserInteractionEnabled = false
            
            findUserAnswer(button: self.selectedButton!)
            
            if self.userAnswer.trimmingCharacters(in: .whitespacesAndNewlines) == self.correctAnswer.trimmingCharacters(in: .whitespacesAndNewlines)
            {
                self.answerIsRight = true
                showFeedback()
                
            } else
            {

                self.answerIsRight = false
                self.numberOfTries += 1

                if self.numberOfTries < 2
                {
                //remove 'Check' button and add 'Try Again' button
                self.selectedButton?.setBackgroundImage(UIImage(named: "wrongOption"), for: .selected)
                    self.multipleChoiceView.setTryAgainButton(tryAgainAction: #selector(setNextTry))
                } else
                {
                    showFeedback()
                }
            }
        }
    }
    
    func showFeedback()
    {
        self.numberOfTries = 0
        
//        let testeController = ViewController()
        let feedbackController = MultipleChoiceFeedbackViewController()
        feedbackController.getVariables(challenge: self.challenge, userAnswer: self.userAnswer, correctAnswer: self.correctAnswer, answerIsRight: self.answerIsRight)
        present(feedbackController, animated: false, completion: nil)
    }
    
    @objc func setNextTry()
    {
        //shuffle the options
        self.options = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: self.options) as! Array<String>
        self.multipleChoiceView.createButtons(options: self.options)
        
        //change buttons (tryAgain vs check)
        self.multipleChoiceView.tryAgainButton.removeFromSuperview()
        self.multipleChoiceView.addSubview(self.multipleChoiceView.checkButton)
        
        //let user change their choice
        multipleChoiceView.optionButton1.isUserInteractionEnabled = true
        multipleChoiceView.optionButton2.isUserInteractionEnabled = true
        multipleChoiceView.optionButton3.isUserInteractionEnabled = true
        multipleChoiceView.optionButton4.isUserInteractionEnabled = true
        
        setRadioButtonController()
    }
    
    @objc func dismissButton(_ sender: Any){
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func helpButton(_ sender: Any){
        let webView = WebDocumentationViewController()
        webView.url = URL(string: self.challenge.resource_link)!
        present(webView, animated: false, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

