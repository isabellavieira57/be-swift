//
//  FeedbackViewController.swift
//  be-swift
//
//  Created by Ana Müller on 11/7/17.
//  Copyright © 2017 Isabella Vieira. All rights reserved.
//

import Foundation
import UIKit

class FeedbackViewController: UIViewController
{
    var feedbackView: FeedbackView!
    var scrollView: UIScrollView!
    var challenge: Challenge!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
//        self.feedbackView = FeedbackView(frame: CGRect.zero, titleText: self.challenge.tags[0] as! String, dismissButtonAction: #selector(dismissButton), helpButtonAction: #selector(helpButton), questionText: self.challenge.question, exampleCodeText: self.challenge.exampleCode, options: self.challenge.options as! Array<String>, correctAnswer: self.challenge.correctAnswer as! Array<String>)
        self.feedbackView = FeedbackView(frame: CGRect.zero, titleText: "teste", dismissButtonAction: #selector(dismissButton), helpButtonAction: #selector(helpButton), questionText: "Perguntaaa?", exampleCodeText: "var teste = 5", options: ["1","2","3","4"], correctAnswer: ["1","2","3","4"])
        
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        scrollView.backgroundColor = UIColor(red:0.96, green:0.96, blue:0.96, alpha:1.0)
        
        self.view.addSubview(scrollView)
        scrollView.addSubview(feedbackView)
        
    //AJEITAR PARAMETROS USER ANSWER E BOOL
//        updateLabelUserAnswer(correctAnswer: self.challenge.correctAnswer as! Array<String>, userAnswer: ["olá"], answerIsRight: false)
//        updateLabelExplanation(feedback: self.challenge.feedbackAnswer, correctAnswer: self.challenge.correctAnswer as! Array<String>, answerIsRight: false)
//        updateButton(answerIsRight: false)
        
//        updateLabelUserAnswer(correctAnswer: ["1"], userAnswer: ["olá"], answerIsRight: false)
        updateLabelExplanation(feedback: "teste teste teste teste teste teste teste teste teste teste teste teste teste teste teste teste teste teste", correctAnswer: ["1"], answerIsRight: false)
        updateButton(answerIsRight: false)
    }
    
//    func updateUserAnserLabelColor()
//    {
//
//    }
    
    func updateLabelExplanation(feedback: String, correctAnswer: Array<String>, answerIsRight: Bool)
    {
        var correctAnswerTxt = correctAnswer[0]
        var labelText: String
        
        if answerIsRight == true
        {
            labelText = feedback
        } else
        {
            labelText = "Correct Answer: \(correctAnswerTxt) \n\n \(feedback)"
        }
        
        self.feedbackView.setLabelExplanation(labelText: labelText)
    }
    
    func updateButton(answerIsRight: Bool)
    {
        if answerIsRight == true
        {
            self.feedbackView.endButton.setBackgroundImage(UIImage(named: "continue"), for: .normal)
        } else
        {
            self.feedbackView.endButton.setBackgroundImage(UIImage(named: "wait24h"), for: .normal)
        }
    }
    
    @objc func dismissButton(_ sender: Any){
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func helpButton(_ sender: Any){
        let webView = WebDocumentationViewController()
        webView.url = URL(string: self.challenge.resource_link)!
        present(webView, animated: false, completion: nil)
    }
}

