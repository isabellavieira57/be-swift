//
//  SortFeedbackViewController.swift
//  be-swift
//
//  Created by Ana Müller on 11/10/17.
//  Copyright © 2017 Isabella Vieira. All rights reserved.
//
import Foundation
import UIKit
import GameplayKit
import Firebase

class SortFeedbackViewController: FeedbackViewController, UITableViewDelegate, UITableViewDataSource
{
    
    var userAnswer: Array<String>!
    var correctAnswer: Array<String>!
    var answerIsRight: Bool!
    var challengeSort: Challenge!
    var tableViewData: Array<String>!
    var topView = TopViewFeedback()
    var sortFeedView = SortFeedbackView()
    var scrollView: UIScrollView!
    let sortView = SortView()
    var viewFeedback = FeedbackView()
    var sizeView: CGFloat!
    var userDAO = UserDAO()

    var arrayUserSuccess: Array<String>!
    var arrayUserFailTitle: Array<String>!
    var numberOfStars: Int!
    var timeSolved: Double!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
      
//        self.sortFeedView = SortFeedbackView(titleText: self.challengeSort.tags[0] as! String, dismissButtonAction: #selector(dismissButton), helpButtonAction: #selector(helpButton), questionText: self.challengeSort.question, options: self.userAnswer)
        
        topView = TopViewFeedback(titleText: self.challengeSort.tags[0] as! String, dismissButtonAction: #selector(dismissButton), helpButtonAction: #selector(helpButton))
        
        let yPosition = topView.yPosition
        
       
        
        self.sortFeedView = SortFeedbackView(questionText: self.challengeSort.question, options: self.userAnswer, starsEarned: self.numberOfStars, timeSolved: self.timeSolved)
        
        self.tableViewData = self.userAnswer
        
        //self.view.addSubview(self.sortFeedView)
        //        //Set scrollView
        //        self.scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: self.sortFeedView.frame.size.width, height: self.sortFeedView.frame.size.height))
        //        self.scrollView.backgroundColor = UIColor(red:0.96, green:0.96, blue:0.96, alpha:1.0)
        //
        //        self.sortFeedView.addSubview(scrollView)
        //        self.scrollView.addSubview(sortFeedView)
        self.view.addSubview(self.sortFeedView)
        
        //Set tableView
        self.sortFeedView.setTableView()
        self.sortFeedView.addSubview(self.sortFeedView.feedbackTableView)

        self.sortFeedView.feedbackTableView.dataSource = self
        self.sortFeedView.feedbackTableView.delegate = self
        self.sortFeedView.feedbackTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        let heightiPhoneSE: CGFloat = 568
        let screenSize = UIScreen.main.bounds
        let yScale = screenSize.height/heightiPhoneSE
        self.sortFeedView.feedbackTableView.rowHeight = sortView.tableRowHeight*yScale
        
        //Set labels and buttons
        addCompareAnswerButtons()
        addLabels()
        
        //Set continue button
        self.sortFeedView.setButton(continueButtonAction: #selector(continueButton(_:)))
        self.sortFeedView.addSubview(self.sortFeedView.buttonContinue)
        sizeView = sortFeedView.sizeView
        self.sortFeedView.frame = CGRect(x: 0, y: 0, width: self.sortFeedView.frame.width, height: sizeView)

        //Set scrollView
        scrollView = UIScrollView(frame: CGRect(x: 0, y: yPosition!, width: self.view.frame.size.width, height: self.view.frame.size.height))
        scrollView.contentSize = CGSize(width: self.view.frame.size.width, height: sizeView)
        self.scrollView.backgroundColor = UIColor(red:0.96, green:0.96, blue:0.96, alpha:1.0)
        self.view.addSubview(topView)
        self.view.addSubview(scrollView)
        scrollView.addSubview(self.sortFeedView)
        
         
        
        //Array de notificações de feedback para o usuário
        self.arrayUserSuccess = ["Yes, you got it!", "You are amazing!", "Nice!", "Congratulations!", "You are going to rule the world!", "Way to go!", "Awesome"]
        self.arrayUserFailTitle = ["Oh no!", "Almost there!", "Keep trying!", "Don't give up!", "Try again! I believe in you!", "Try again! You can do it!"]
        
        let userID : String = (Auth.auth().currentUser?.email)!
       // print ("userID: ", userID)
        
        userDAO.saveChallengeData(email: userID, challenge_id: self.challengeSort.id, stars: self.numberOfStars!, time: self.timeSolved!)
        
    }
    
//    // Descomentar para feedback alerts aparecerem
//    override func viewDidAppear(_ animated: Bool) {
//        showFeedbackAlert(starsEarned: self.numberOfStars)
//    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return userAnswer.count
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
    
    func addLabels()
    {
        self.sortFeedView.setUserLabelsAndIcons()
        
        if self.answerIsRight == true
        {
            self.sortFeedView.addSubview(self.sortFeedView.starsIcon)
            self.sortFeedView.addSubview(self.sortFeedView.timeIcon)
            self.sortFeedView.addSubview(self.sortFeedView.timeLabel)
            self.sortFeedView.addSubview(self.sortFeedView.labelCorrectUserAnswer)
            
            self.sortFeedView.setLabelExplanation(labelText: self.challengeSort.feedbackAnswer, previousLabel: self.sortFeedView.labelCorrectUserAnswer)
        } else
        {
            self.sortFeedView.labelWrongUserAnswer.frame.origin.y = self.sortFeedView.buttonYourAnswer.frame.origin.y + self.sortFeedView.buttonYourAnswer.frame.height + 10
            
            self.sortFeedView.addSubview(self.sortFeedView.labelWrongUserAnswer)
            
            self.sortFeedView.setLabelExplanation(labelText: self.challengeSort.feedbackAnswer, previousLabel: self.sortFeedView.labelWrongUserAnswer)
        }
        self.sortFeedView.addSubview(self.sortFeedView.labelExplanation)
    }
    
    func getSortVariables(challenge: Challenge, userAnswer: Array<String>, correctAnswer: Array<String>, answerIsRight: Bool, numberOfStars: Int, timeSolved: Double)
    {
        self.challengeSort = challenge
        self.userAnswer = userAnswer
        self.correctAnswer = correctAnswer
        self.answerIsRight = answerIsRight
        self.numberOfStars = numberOfStars
        self.answerIsRight = answerIsRight
        self.numberOfStars = numberOfStars
        self.timeSolved = timeSolved
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
        self.sortFeedView.buttonYourAnswer.setBackgroundImage(UIImage(named: "yourAnswerBold"), for: .normal)
        self.sortFeedView.buttonCorrectAnswer.setBackgroundImage(UIImage(named: "correctAnswer"), for: .normal)
        self.tableViewData = self.userAnswer
        self.sortFeedView.feedbackTableView.reloadData()
    }
    
    @objc func showCorrectAnswer()
    {
        self.sortFeedView.buttonYourAnswer.setBackgroundImage(UIImage(named: "yourAnswer"), for: .normal)
        self.sortFeedView.buttonCorrectAnswer.setBackgroundImage(UIImage(named: "correctAnswerBold"), for: .normal)
        self.tableViewData = self.correctAnswer
        self.sortFeedView.feedbackTableView.reloadData()
    }
    
    func showFeedbackAlert(starsEarned: Int) {
        var title: String!
        var message:String!
        var timeToPrint = Int(timeSolved)
        
        switch starsEarned {
        case 3:
            title = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: self.arrayUserSuccess)[0] as! String
            message = "WOW, you answered in \(timeToPrint) seconds! You got 3 stars!\nKeep it up 😄"
        case 2:
            title = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: self.arrayUserSuccess)[0] as! String
            message = "You answered in \(timeToPrint) seconds!\n You got 2 stars, there's still room for improvement 😉"
        case 1:
            title = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: self.arrayUserSuccess)[0] as! String
            message = "You answered in \(timeToPrint) seconds, so you got 1 star!\nLet's work on your speed to achieve greater results 😊"
        case 0:
            title = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: self.arrayUserFailTitle)[0] as! String
            message = "You didn't get it this time 😕\nCheck out the explanation, study a bit more and try again!"
        default:
            title = "Ops!"
            message = "Sorry, we got an error. My bad! Please try again."
        }
    
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(defaultAction)
        self.present(alert, animated: true, completion: nil)
    }
}
