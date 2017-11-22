//
//  SortViewController.swift
//  be-swift
//
//  Created by Ana Müller on 10/19/17.
//  Copyright © 2017 Isabella Vieira. All rights reserved.
//
import Foundation
import UIKit
import GameplayKit

class SortViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var sortView: SortView!
    var codeToSort: Array<String> = []
    var userAnswer: Array<String>!
    var answerIsRight: Bool!
    var challenge: Challenge!
    var scrollView: UIScrollView!
    var numberOfTries = 0
    var correctAnswer: Array<String>!
    
    let progressView = UIProgressView(progressViewStyle: .bar)
    var time = 0.0
    var timer = Timer()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.correctAnswer = self.challenge.correctAnswer as! Array<String>
        
        sortView = SortView(progressView: progressView, frame: CGRect.zero, titleText: self.challenge.tags[0] as! String, dismissButtonAction: #selector(SortViewController.dismissButton(_:)), helpButtonAction: #selector(SortViewController.helpButton(_:)), checkButtonAction: #selector(checkAnswer), questionText: self.challenge.question, exampleCodeText: self.challenge.exampleCode, options: self.challenge.options as! Array<String>, correctAnswer: self.correctAnswer)
        
        //Set scrollView
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        scrollView.contentSize = CGSize(width: self.view.frame.size.width, height: sortView.frame.height)
        
        self.view.addSubview(scrollView)
        scrollView.addSubview(sortView)
        
        //Set tableView
        self.sortView.sortTableView.dataSource = self
        self.sortView.sortTableView.delegate = self
        self.sortView.sortTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.sortView.sortTableView.isEditing = true
        self.codeToSort = self.sortView.codeToSort
        
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return codeToSort.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.backgroundColor = UIColor(red:0.16, green:0.17, blue:0.21, alpha:1.0)
        cell.textLabel?.text = self.codeToSort[indexPath.row]
        cell.textLabel?.textColor = UIColor.white
        self.sortView.view.labelDidChange(cell.textLabel!)
        
        return cell
    }
    
    //Enables rearrengement of lines
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool
    {
        return true
    }
    
    //Rearrenges lines
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath)
    {
        let rearrangedLine = codeToSort[sourceIndexPath.row]
        codeToSort.remove(at: sourceIndexPath.row)
        codeToSort.insert(rearrangedLine, at: destinationIndexPath.row)
        NSLog("%@", "\(sourceIndexPath.row) => \(destinationIndexPath.row) \(codeToSort)")
        self.sortView.sortTableView.reloadData()
    }
    
    //Disable delete buttons when editing the order of cells
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle
    {
        return .none
    }
    
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool
    {
        return false
    }
    
    @objc func checkAnswer()
    {
        self.sortView.sortTableView.isEditing = false
        
        self.userAnswer = codeToSort
        
        if userAnswer == self.correctAnswer
        {
            timer.invalidate()
            print(time)
            print("CORRECT ANSWER")
            
            self.answerIsRight = true
            showFeedback()
            
        } else
        {
            self.answerIsRight = false
            self.numberOfTries += 1
            print("WRONG ANSWER")
            
            if self.numberOfTries < 2
            {
                self.sortView.setTryAgainButton(tryAgainAction: #selector(setNextTry))
                
            } else
            {
                showFeedback()
            }
        }
    }
    
    func showFeedback()
    {
        self.numberOfTries = 0
        
        let feedbackController = SortFeedbackViewController()
        feedbackController.getSortVariables(challenge: self.challenge, userAnswer: self.userAnswer, correctAnswer: self.correctAnswer, answerIsRight: self.answerIsRight)
        present(feedbackController, animated: false, completion: nil)
    }
    
    @objc func setNextTry()
    {
        //change buttons
        self.sortView.tryAgainButton.removeFromSuperview()
        self.sortView.addSubview(self.sortView.checkButton)
        
        //shuffle the code
        self.codeToSort = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: self.codeToSort) as! Array<String>
        self.sortView.sortTableView.reloadData()
        
        //let user sort the code
        self.sortView.sortTableView.isEditing = true
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
