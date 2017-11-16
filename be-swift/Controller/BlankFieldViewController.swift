//
//  BlankFieldViewController.swift
//  be-swift
//
//  Created by Mariana Meireles on 25/10/17.
//  Copyright © 2017 Isabella Vieira. All rights reserved.
//

import Foundation
import UIKit

class BlankFieldViewController: UIViewController, UITextFieldDelegate {
    
    var blankField: BlankFieldView!
    var scrollView: UIScrollView!
    var challenge: Challenge!
    var answerIsRight: Bool!
    var userAnswer: String!
    var correctAnswer: String!
    var numberOfTries = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.correctAnswer = self.challenge.correctAnswer[0] as! String
        
        blankField = BlankFieldView(titleText: self.challenge.tags[0] as! String, dismissButtonAction: #selector(BlankFieldViewController.dismissButton(_:)), helpButtonAction: #selector(BlankFieldViewController.helpButton(_:)), questionText: self.challenge.question, exampleCodeText: self.challenge.exampleCode, checkButtonAction:#selector(BlankFieldViewController.checkButton(_:)), currentView: self)
        
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        scrollView.contentSize = CGSize(width: self.view.frame.size.width, height: blankField.frame.height)
        self.view.addSubview(scrollView)
        scrollView.addSubview(blankField)
    }
    
    @objc func dismissButton(_ sender: Any){
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func helpButton(_ sender: Any){
        let webView = WebDocumentationViewController()
        webView.url = URL(string: self.challenge.resource_link)!
        present(webView, animated: false, completion: nil)
    }
    
    @objc func checkButton(_ sender: Any)
    {
        
        self.blankField.blankField.endEditing(true)
        
        self.userAnswer = self.blankField.blankField.text
        
        if self.userAnswer?.lowercased() == self.correctAnswer.lowercased()
        {
            self.answerIsRight = true
            showFeedback()
        
        } else
        {
            self.answerIsRight = false
            self.numberOfTries += 1
 
            if self.numberOfTries < 2
            {
                self.blankField.setTryAgainButton(tryAgainAction: #selector(setNextTry))
                
            } else
            {
                showFeedback()
            }
        }
    }
    
    func showFeedback()
    {
        self.numberOfTries = 0
        
        let feedbackController = MultipleChoiceFeedbackViewController()
        feedbackController.getVariables(challenge: self.challenge, userAnswer: self.userAnswer, correctAnswer: self.correctAnswer, answerIsRight: self.answerIsRight)
        present(feedbackController, animated: false, completion: nil)
    }
    
    @objc func setNextTry()
    {
        //change buttons
        self.blankField.tryAgainButton.removeFromSuperview()
        self.blankField.addSubview(self.blankField.checkButton)

        //erase previous answer and let user edit blank field
        self.blankField.blankField.text = ""
        self.blankField.blankField.endEditing(false)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let heightiPhoneSE: CGFloat = 568
        let screenSize = UIScreen.main.bounds
        let yScale = screenSize.height/heightiPhoneSE
        scrollView.setContentOffset(CGPoint(x: 0, y: textField.frame.minY - 250*yScale), animated: true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        scrollView.setContentOffset(CGPoint(x: 0, y: scrollView.contentSize.height - self.view.frame.height), animated: true)
    }
}

