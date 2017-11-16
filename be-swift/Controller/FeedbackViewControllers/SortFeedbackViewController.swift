//
//  SortFeedbackViewController.swift
//  be-swift
//
//  Created by Ana Müller on 11/10/17.
//  Copyright © 2017 Isabella Vieira. All rights reserved.
//

import Foundation
import UIKit

class sortFeedbackViewController: FeedbackViewController, UITableViewDelegate, UITableViewDataSource
{
    
    var userAnswer: Array<String>!
    var correctAnswer: Array<String>!
    var answerIsRight: Bool!
    var challengeSort: Challenge!
    var tableViewData: Array<String>!
    var sortFeedView = SortFeedbackView()
    var scrollView: UIScrollView!
    let sortView = SortView()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        self.sortFeedView = SortFeedbackView(titleText: self.challengeSort.tags[0] as! String, dismissButtonAction: #selector(dismissButton), helpButtonAction: #selector(helpButton), questionText: self.challengeSort.question)
        
        self.tableViewData = self.userAnswer
        
        //Set scrollView
        self.scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: self.sortFeedView.frame.size.width, height: self.sortFeedView.frame.size.height))
        self.scrollView.backgroundColor = UIColor(red:0.96, green:0.96, blue:0.96, alpha:1.0)
        
        self.sortFeedView.addSubview(scrollView)
        self.scrollView.addSubview(sortFeedView)
        
        //Set tableView
        self.sortFeedView.setTableView()
        self.sortFeedView.addSubview(self.sortFeedView.feedbackTableView)
        
        //Set labels and buttons
        addCompareAnswerButtons()
        addFeedbackLabels()
        
        //Set continue button
        self.sortFeedView.setButton(continueButtonAction: #selector(continueButton(_:)))
        self.sortFeedView.addSubview(self.sortFeedView.buttonContinue)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return correctAnswer.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.backgroundColor = UIColor(red:0.16, green:0.17, blue:0.21, alpha:1.0)
        cell.textLabel?.text = self.tableViewData[indexPath.row]
        cell.textLabel?.textColor = UIColor.white
        self.sortView.view.labelDidChange(cell.textLabel!)
        return cell
    }
    
    func addCompareAnswerButtons()
    {
        if self.answerIsRight == false
        {
            self.sortFeedView.setCompareAnswersButtons(showYourAnswer: #selector(showYourAnswer), showCorrectAnswer: #selector(showCorrectAnswer))
            self.sortFeedView.addSubview(self.sortFeedView.buttonYourAnswer)
            self.sortFeedView.addSubview(self.sortFeedView.buttonCorrectAnswer)
        }
    }
    
    func addFeedbackLabels()
    {
        self.feedbackView.setLabelUserAnswer(labelText: "")
        self.sortFeedView.positionUserLabels()
        
        if self.answerIsRight == true
        {
            self.sortFeedView.labelCorrectUserAnswer.text = "Congratulations, your answer is correct!"
            self.sortFeedView.addSubview(self.sortFeedView.labelCorrectUserAnswer)
            
            self.sortFeedView.setLabelExplanation(labelText: self.challengeSort.feedbackAnswer, previousLabel: self.sortFeedView.labelCorrectUserAnswer)
        } else
        {
            self.sortFeedView.labelWrongUserAnswer.text = "That's not it! Compare the answers with the buttons above."
            self.sortFeedView.addSubview(self.sortFeedView.labelWrongUserAnswer)
            
            self.sortFeedView.setLabelExplanation(labelText: self.challengeSort.feedbackAnswer, previousLabel: self.sortFeedView.labelWrongUserAnswer)
        }
        self.sortFeedView.addSubview(self.sortFeedView.labelExplanation)
    }
    
    func getSortVariables(challenge: Challenge, userAnswer: Array<String>, correctAnswer: Array<String>, answerIsRight: Bool)
    {
        self.challengeSort = challenge
        self.userAnswer = userAnswer
        self.correctAnswer = correctAnswer
        self.answerIsRight = answerIsRight
    }
    
    @objc func dismissButton(_ sender: Any){
        self.view.window!.rootViewController?.dismiss(animated: false, completion: nil)
    }
    
    @objc func helpButton(_ sender: Any){
        let webView = WebDocumentationViewController()
        webView.url = URL(string: self.challengeSort.resource_link)!
        present(webView, animated: false, completion: nil)
    }
    
    @objc func continueButton(_ sender: Any)
    {
        self.view.window!.rootViewController?.dismiss(animated: false, completion: nil)
    }
    
    @objc func showYourAnswer()
    {
        self.tableViewData = self.userAnswer
        self.sortFeedView.feedbackTableView.reloadData()
    }
    
    @objc func showCorrectAnswer()
    {
        self.tableViewData = self.correctAnswer
        self.sortFeedView.feedbackTableView.reloadData()
    }
}
