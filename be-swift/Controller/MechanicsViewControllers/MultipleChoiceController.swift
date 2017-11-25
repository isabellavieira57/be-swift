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
    var topView: TopView!
    var radioButtonController: SSRadioButtonsController?
    var userAnswer = ""
    var answerIsRight: Bool!
    var selectedButton: SSRadioButton?
    var challenge: Challenge!
    var scrollView: UIScrollView!
    var correctAnswer: String!
    var options: Array<String>!
    var numberOfTries = 0
    
    let progressView = UIProgressView(progressViewStyle: .bar)
    var time = 0.0
    var timer = Timer()
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        self.correctAnswer = self.challenge.correctAnswer[0] as! String
        self.options = self.challenge.options as! Array<String>
        
        topView = TopView(progressView: progressView, titleText: self.challenge.tags[0] as! String, dismissButtonAction: #selector(MultipleChoiceController.dismissButton(_:)), helpButtonAction: #selector(MultipleChoiceController.helpButton(_:)))
        
        multipleChoiceView = MultipleChoiceView(checkButtonAction: #selector(checkAnswer), questionText: self.challenge.question, exampleCodeText: self.challenge.exampleCode, options: self.options, correctAnswer: self.correctAnswer)
        
        let yPosition = topView.yPosition
        
        //Set scrollView
        scrollView = UIScrollView(frame: CGRect(x: 0, y: yPosition!, width: self.view.frame.size.width, height: self.view.frame.size.height))
        scrollView.contentSize = CGSize(width: self.view.frame.size.width, height: multipleChoiceView.frame.height)
        
        self.view.addSubview(topView)
        self.view.addSubview(scrollView)
        scrollView.addSubview(multipleChoiceView)

        setRadioButtonController()
        
        timer = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(startTime), userInfo: nil, repeats: true)
    }
    
    override func viewDidAppear(_ animated: Bool){
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: TimeInterval(self.challenge.estimatedTime), animations: { () -> Void in
            self.progressView.setProgress(0.0, animated: true)
        })
    }
    
    @objc func startTime(){
        time += 0.2
    }
    
    func setRadioButtonController(){
        radioButtonController = SSRadioButtonsController(buttons: multipleChoiceView.optionButton1, multipleChoiceView.optionButton2, multipleChoiceView.optionButton3, multipleChoiceView.optionButton4)
        radioButtonController!.delegate = self
        radioButtonController!.shouldLetDeSelect = true
    }
    
    func didSelectButton(selectedButton: SSRadioButton?){
        NSLog(" \(selectedButton)" )
        self.selectedButton = selectedButton
        print("SELECTED BUTTON: ", self.selectedButton?.optionLabel.text)
    }
    
    func findUserAnswer(button: SSRadioButton){
        self.userAnswer = (button.optionLabel.text)!
        print(userAnswer)
    }
    
    @objc func checkAnswer(){
        if selectedButton == nil{
            let alert = UIAlertController(title: "Ops!", message: "Select an option", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        }else{
            timer.invalidate()
            print("TIME", time)
            time = 0.0
            
            multipleChoiceView.optionButton1.isUserInteractionEnabled = false
            multipleChoiceView.optionButton2.isUserInteractionEnabled = false
            multipleChoiceView.optionButton3.isUserInteractionEnabled = false
            multipleChoiceView.optionButton4.isUserInteractionEnabled = false
            
            findUserAnswer(button: self.selectedButton!)
            
            if self.userAnswer.trimmingCharacters(in: .whitespacesAndNewlines) == self.correctAnswer.trimmingCharacters(in: .whitespacesAndNewlines){
                print("CORRECT ANSWER")
                
                self.answerIsRight = true
                showFeedback()
                
            }else{

                self.answerIsRight = false
                self.numberOfTries += 1
//                timer.invalidate()

                if self.numberOfTries < 2{
                //remove 'Check' button and add 'Try Again' button
                self.selectedButton?.setBackgroundImage(UIImage(named: "wrongOption"), for: .selected)
                    UIView.animate(withDuration: TimeInterval(0), animations: { () -> Void in
                        self.progressView.setProgress(1.0, animated: true)
                    })
                    self.multipleChoiceView.setTryAgainButton(tryAgainAction: #selector(setNextTry))
                }else{
                    showFeedback()
                }
            }
        }
    }
    
    func showFeedback(){
        self.numberOfTries = 0
        
//        let testeController = ViewController()
        let feedbackController = MultipleChoiceFeedbackViewController()
        feedbackController.getVariables(challenge: self.challenge, userAnswer: self.userAnswer, correctAnswer: self.correctAnswer, answerIsRight: self.answerIsRight)
        present(feedbackController, animated: false, completion: nil)
    }
    
    @objc func setNextTry(){
        UIView.animate(withDuration: TimeInterval(self.challenge.estimatedTime), animations: { () -> Void in
            self.progressView.setProgress(0.0, animated: true)
        })
        
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
        
        timer = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(startTime), userInfo: nil, repeats: true)
//        self.time = 0.0
//        startTime()
    }
    
    @objc func dismissButton(_ sender: Any){
        print(#function)
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

