//
//  DragAndDropViewController.swift
//  be-swift
//
//  Created by Mariana Meireles on 22/11/17.
//  Copyright © 2017 Isabella Vieira. All rights reserved.
//

import Foundation
import UIKit

class DragAndDropViewController: UIViewController {
    
    var dragAndDrop: DragAndDropView!
    var scrollView: UIScrollView!
    var challenge: Challenge!
    var answerIsRight: Bool!
    var userAnswer: String!
    var correctAnswer: String!
    var numberOfTries = 0
    
    let progressView = UIProgressView(progressViewStyle: .bar)
    var time = 0.0
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.correctAnswer = self.challenge.correctAnswer[0] as! String
        
        dragAndDrop = DragAndDropView(progressView: progressView, titleText: self.challenge.tags[0] as! String, dismissButtonAction: #selector(DragAndDropViewController.dismissButton(_:)), helpButtonAction: #selector(DragAndDropViewController.helpButton(_:)), questionText: self.challenge.question, exampleCodeText: self.challenge.exampleCode, options: self.challenge.options as! [String])
        
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        scrollView.contentSize = CGSize(width: self.view.frame.size.width, height: dragAndDrop.frame.height)
        self.view.addSubview(scrollView)
        scrollView.addSubview(dragAndDrop)
        
        timer = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(startTime), userInfo: nil, repeats: true)
    }
    
    override func viewDidAppear(_ animated: Bool){
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: TimeInterval(self.challenge.estimatedTime), animations: { () -> Void in
            self.progressView.setProgress(0.0, animated: true)
        })
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in (touches){
            let location = touch.location(in: self.dragAndDrop)
            let drag = dragAndDrop.title
            
            if dragAndDrop.title.frame.contains(location){
                scrollView.isUserInteractionEnabled = true
                print ("TOUCHED")
            }
            print ("TOUCHED2")

        }
        print ("TOUCHED3")

    }
    
    @objc func startTime(){
        time += 0.2
    }
    
    @objc func dismissButton(_ sender: Any){
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func helpButton(_ sender: Any){
        let webView = WebDocumentationViewController()
        webView.url = URL(string: self.challenge.resource_link)!
        present(webView, animated: false, completion: nil)
    }
    
    /*
    @objc func checkButton(_ sender: Any){
        self.blankField.blankField.isUserInteractionEnabled = false
        
        if textFieldInput == nil{
            let alert = UIAlertController(title: "Ops!", message: "complete the blank field", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            self.blankField.blankField.isUserInteractionEnabled = true
        }else{
            
            timer.invalidate()
            print("TIME", time)
            time = 0.0
            
            self.userAnswer = textFieldInput
            
            if userAnswer.lowercased() == self.correctAnswer.lowercased() {
                print("CORRECT ANSWER")
                
                self.answerIsRight = true
                showFeedback()
            }else{
                print("WRONG ANSWER")
                
                self.answerIsRight = false
                self.numberOfTries += 1
                print("TRIES: ", numberOfTries)
                
                if self.numberOfTries < 2 {
                    UIView.animate(withDuration: TimeInterval(0), animations: { () -> Void in
                        self.progressView.setProgress(1.0, animated: true)
                    })
                    self.blankField.setTryAgainButton(tryAgainAction: #selector(setNextTry))
                }else{
                    showFeedback()
                }
            }
        }
    }
 
    func showFeedback(){
        self.numberOfTries = 0
        
        let feedbackController = MultipleChoiceFeedbackViewController()
        feedbackController.getVariables(challenge: self.challenge, userAnswer: self.userAnswer, correctAnswer: self.correctAnswer, answerIsRight: self.answerIsRight)
        present(feedbackController, animated: false, completion: nil)
    }
    
    @objc func setNextTry(){
        
        UIView.animate(withDuration: TimeInterval(self.challenge.estimatedTime), animations: { () -> Void in
            self.progressView.setProgress(0.0, animated: true)
        })
        
        //change buttons
        self.blankField.tryAgainButton.removeFromSuperview()
        self.blankField.addSubview(self.blankField.checkButton)
        
        //erase previous answer and let user edit blank field
        self.blankField.blankField.text = ""
        self.blankField.blankField.isUserInteractionEnabled = true
        
        timer = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(startTime), userInfo: nil, repeats: true)
    }
 
     */

 
}


