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
        self.view.addSubview(scrollView)
        scrollView.addSubview(feedbackView)
        
    //AJEITAR PARAMETROS USER ANSWER E BOOL
        updateLabelUserAnswer(correctAnswer: self.challenge.correctAnswer as! Array<String>, userAnswer: ["olá"], answerIsRight: false)
        updateLabelExplanation(feedback: self.challenge.feedbackAnswer, correctAnswer: self.challenge.correctAnswer as! Array<String>, answerIsRight: false)
        updateButton(answerIsRight: false)
        
        if self.challenge.mechanics == "Sort"
        {
    //AJEITAR PARAMETROS USER ANSWER E BOOL
            feedbackSortView(correctAnswer: self.challenge.correctAnswer as! Array<String>, answerIsRight: false)
        }
        
    }
    
    func updateLabelUserAnswer(correctAnswer: Array<String>, userAnswer: Array<String>, answerIsRight: Bool)
    {
        let correctAnswerTxt = correctAnswer[0]
        let userAnswerTxt = userAnswer[0]
        
        if self.challenge.mechanics == "Sort"
        {
            self.feedbackView.userAnswerLabel.frame.origin.y = self.feedbackView.userAnswerSortButton.frame.origin.y + self.feedbackView.userAnswerSortButton.frame.height + 10
        }
        
        if answerIsRight == true
        {
            self.feedbackView.userAnswerLabel.text = "You answered correctly: " + correctAnswerTxt
            self.feedbackView.userAnswerLabel.textColor = UIColor(red:0.82, green:1.9, blue:0.91, alpha:1.0)
        } else
        {
            self.feedbackView.userAnswerLabel.text = "Your answer: " + userAnswerTxt
            self.feedbackView.userAnswerLabel.textColor = UIColor(red:2.35, green:0.32, blue:0.57, alpha:1.0)
        }
    }
    
    func updateLabelExplanation(feedback: String, correctAnswer: Array<String>, answerIsRight: Bool)
    {
        var correctAnswerTxt = correctAnswer[0]
        
        if answerIsRight == true || self.challenge.mechanics == "Sort" || self.challenge.mechanics == "DragAndDrop"
        {
            self.feedbackView.explanationLabel.text = feedback
        } else
        {
            self.feedbackView.explanationLabel.text = "Correct Answer: \(correctAnswerTxt) \n \(feedback)"
        }
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
    
    func feedbackSortView(correctAnswer: Array<String>, answerIsRight: Bool)
    {
        if answerIsRight == false
        {
            self.feedbackView.userAnswerLabel.text = "That's not it! Compare your answer with the correct one through the buttons above."
            //add TableView with correct answer and buttons so the user can compare the answers
//            self.feedbackView.setTableView()
            self.feedbackView.setSortAnswerButtons()
        } else
        {
            self.feedbackView.userAnswerLabel.text = "Congratulations, your answer is correct!"
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

