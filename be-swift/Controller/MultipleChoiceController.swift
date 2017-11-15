//
//  MultipleChoiceController.swift
//  be-swift
//
//  Created by Ana Müller on 10/23/17.
//  Copyright © 2017 Isabella Vieira. All rights reserved.
//


import UIKit

class MultipleChoiceController: UIViewController, SSRadioButtonControllerDelegate {
    
    var multipleChoiceView: MultipleChoiceView!
    var radioButtonController: SSRadioButtonsController?
    var userAnswer = ""
    var answerIsRight: Bool!
    var selectedButton: SSRadioButton?
    var challenge: Challenge!
    var scrollView: UIScrollView!
    var correctAnswer: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.correctAnswer = self.challenge.correctAnswer[0] as! String
        self.correctAnswer.trimmingCharacters(in: .whitespacesAndNewlines)
        
        multipleChoiceView = MultipleChoiceView(titleText: self.challenge.tags[0] as! String, dismissButtonAction: #selector(dismissButton), helpButtonAction: #selector(helpButton), questionText: self.challenge.question, exampleCodeText: self.challenge.exampleCode, options: self.challenge.options as! Array<String>, correctAnswer: self.correctAnswer)
        
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        scrollView.contentSize = CGSize(width: self.view.frame.size.width, height: multipleChoiceView.frame.height)
        self.view.addSubview(scrollView)
        
        scrollView.addSubview(multipleChoiceView)
        //self.view.addSubview(multipleChoiceView)
        //self.view = self.multipleChoiceView
        radioButtonController = SSRadioButtonsController(buttons: multipleChoiceView.optionButton1, multipleChoiceView.optionButton2, multipleChoiceView.optionButton3, multipleChoiceView.optionButton4)
        radioButtonController!.delegate = self
        radioButtonController!.shouldLetDeSelect = true
        
        multipleChoiceView.checkButton.addTarget(self, action: #selector(checkAnswer), for: .touchUpInside)
    }
    
    func didSelectButton(selectedButton: SSRadioButton?) {
        NSLog(" \(selectedButton)" )
        self.selectedButton = selectedButton
    }
    
    func findUserAnswer(button: SSRadioButton) {
        self.userAnswer = (button.optionLabel.text)! as! String
        self.userAnswer.trimmingCharacters(in: .whitespacesAndNewlines)
        print(userAnswer)
    }
    
    @objc func checkAnswer() {
        
        if selectedButton == nil {
            //add message: please select an option
        } else {
            multipleChoiceView.optionButton1.isUserInteractionEnabled = false
            multipleChoiceView.optionButton2.isUserInteractionEnabled = false
            multipleChoiceView.optionButton3.isUserInteractionEnabled = false
            multipleChoiceView.optionButton4.isUserInteractionEnabled = false
            
            findUserAnswer(button: self.selectedButton!)
            
            print("USER ANSWER: \(userAnswer)")
            print("RESPOSTA: \(self.userAnswer == self.correctAnswer)")
            print("CERTO: \(self.correctAnswer)")
            
            if self.userAnswer == self.correctAnswer {
                
                self.answerIsRight = true
                
            } else {

                self.answerIsRight = false

                //remove 'Check' button and add 'Try Again' button
                self.selectedButton?.setBackgroundImage(UIImage(named: "wrongOption"), for: .selected)
                
                if self.multipleChoiceView.checkButton.image(for: .normal) == UIImage(named: "continue")
                {
                    self.multipleChoiceView.checkButton.setBackgroundImage(UIImage(named: "tryAgain"), for: .normal)
                }  else
                {
                    //Refresh challenge
                }
            }
            
            let feedbackController = MultipleChoiceFeedbackViewController()
            feedbackController.getMultipleChoiceVariables(challenge: self.challenge,userAnswer: self.userAnswer, correctAnswer: self.correctAnswer, answerIsRight: self.answerIsRight)
            present(feedbackController, animated: false, completion: nil)
        }
    }
    
//    func bringVariableValues() -> (challenge: Challenge, correctAnswer: String, userAnswer: String, answerIsRight: Bool)
//    {
//        print("CHALLENGE!! ", self.challenge)
//        print("CORRECT ANSWER!! ", self.correctAnswer)
//        print("BOOL!! ", self.answerIsRight)
//        print("USER ANSWER!! ", self.userAnswer)
//        return (self.challenge, self.correctAnswer, self.userAnswer, self.answerIsRight)
//    }
    
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

