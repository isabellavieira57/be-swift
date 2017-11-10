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
        
        self.feedbackView = FeedbackView(frame: CGRect.zero, titleText: self.challenge.tags[0] as! String, dismissButtonAction: #selector(dismissButton), helpButtonAction: #selector(helpButton), questionText: self.challenge.question, exampleCodeText: self.challenge.exampleCode, options: self.challenge.options as! Array<String>, correctAnswer: self.challenge.correctAnswer as! Array<String>)
//        self.feedbackView = FeedbackView(frame: CGRect.zero, titleText: "teste", dismissButtonAction: #selector(dismissButton), helpButtonAction: #selector(helpButton), questionText: "Perguntaaa?", exampleCodeText: "var teste = 5", options: ["1","2","3","4"], correctAnswer: ["1","2","3","4"])
        
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        scrollView.backgroundColor = UIColor(red:0.96, green:0.96, blue:0.96, alpha:1.0)
        
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
        
        var labelText: String
        var textColor: UIColor
        var yPosition: CGFloat
        
        if self.challenge.mechanics == "Sort"
        {
            yPosition = self.feedbackView.userAnswerSortButton.frame.origin.y + self.feedbackView.userAnswerSortButton.frame.height
        } else
        {
                yPosition = 223
        }
        
        if answerIsRight == true
        {
            labelText = "You answered correctly: " + correctAnswerTxt
            textColor = UIColor(red:0.28, green:0.64, blue:0.31, alpha:1.0)
        } else
        {
            labelText = "Your answer: " + userAnswerTxt
            textColor = UIColor(red:2.35, green:0.32, blue:0.57, alpha:1.0)
        }
        
        self.feedbackView.setLabelUserAnswer(labelText: labelText, textColor: textColor, yPosition: yPosition)
    }
    
    func updateLabelExplanation(feedback: String, correctAnswer: Array<String>, answerIsRight: Bool)
    {
        var correctAnswerTxt = correctAnswer[0]
        var labelText: String
        
        if answerIsRight == true || self.challenge.mechanics == "Sort" || self.challenge.mechanics == "DragAndDrop"
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
    
    func feedbackSortView(correctAnswer: Array<String>, answerIsRight: Bool)
    {
        if answerIsRight == false
        {
            self.feedbackView.userAnswerLabel.text = "That's not it! Compare your answer with the correct one through the buttons above."
            //add TableView with correct answer and buttons so the user can compare the answers
            self.feedbackView.setTableView()
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

