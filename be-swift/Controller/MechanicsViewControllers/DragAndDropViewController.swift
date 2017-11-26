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
    var topView: TopView!
    var scrollView: UIScrollView!
    var challenge: Challenge!
    var answerIsRight: Bool!
    var userAnswer: String!
    var correctAnswer: [String]!
    var numberOfTries = 0
    var labels: [UILabel]!
    var panGestures : [UIPanGestureRecognizer]!
    var drop: UIImageView!
    var positions: [CGPoint]!
    var labelsInDrop = [String]()
    var userDAO: UserDAO!

    
    let progressView = UIProgressView(progressViewStyle: .bar)
    var time = 0.0
    var timer = Timer()
    
    var numberOfStars: Int!
    var timeSolved: Double!
    var timeTo2Stars: Double! = nil
    var timeTo3Stars: Double! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.correctAnswer = self.challenge.correctAnswer as! [String]
        
        topView = TopView(titleText: self.challenge.tags[0] as! String, dismissButtonAction: #selector(DragAndDropViewController.dismissButton(_:)), helpButtonAction: #selector(DragAndDropViewController.helpButton(_:)))
        
//        dragAndDrop = DragAndDropView(progressView: progressView, titleText: self.challenge.tags[0] as! String, dismissButtonAction: #selector(DragAndDropViewController.dismissButton(_:)), helpButtonAction: #selector(DragAndDropViewController.helpButton(_:)), questionText: self.challenge.question, exampleCodeText: self.challenge.exampleCode, options: self.challenge.options as! [String], checkButtonAction: #selector(DragAndDropViewController.checkButton(_:)))
        dragAndDrop = DragAndDropView(questionText: self.challenge.question, exampleCodeText: self.challenge.exampleCode, options: self.challenge.options as! [String], checkButtonAction: #selector(DragAndDropViewController.checkButton(_:)))
        
        drop = dragAndDrop.drop
        labels = dragAndDrop.titles
        
        let yPosition = topView.yPosition

        scrollView = UIScrollView(frame: CGRect(x: 0, y: yPosition!, width: self.view.frame.size.width, height: self.view.frame.size.height))
        scrollView.contentSize = CGSize(width: self.view.frame.size.width, height: dragAndDrop.frame.height)
        
        self.view.addSubview(scrollView)
        scrollView.addSubview(dragAndDrop)
        self.view.addSubview(topView)

        
        positions = [CGPoint]()
        panGestures = [UIPanGestureRecognizer]()
        var gesture : UIPanGestureRecognizer!
        
        for label in labels{
            positions.append(label.frame.origin)
            gesture = UIPanGestureRecognizer.init(target: self, action: #selector(DragAndDropViewController.viewDidDragged(_:)))
            panGestures.append(gesture)
            label.addGestureRecognizer(gesture)
        }
        
        timer = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(startTime), userInfo: nil, repeats: true)
        
        //Set time required to get x stars
        self.timeTo3Stars = self.challenge.estimatedTime
        self.timeTo2Stars = timeTo3Stars*2

    }
    
    override func viewDidAppear(_ animated: Bool){
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: TimeInterval(self.challenge.estimatedTime), animations: { () -> Void in
            self.progressView.setProgress(0.0, animated: true)
        })
    }
    
    @objc func viewDidDragged(_ sender: UIPanGestureRecognizer){
        
        let heightiPhoneSE: CGFloat = 568
        let screenSize = UIScreen.main.bounds
        let yScale = screenSize.height/heightiPhoneSE
        
        let view = sender.view!
        let label = sender.view! as! UILabel
        let newPoint = sender.location(in: self.dragAndDrop)
        view.layer.zPosition = 2
        view.center = newPoint
        if(sender.state == .ended){
            if(drop.frame.contains(newPoint)){
                view.frame.origin = CGPoint(x: positions[view.tag-1].x, y: positions[view.tag-1].y - 114*yScale)
                labelsInDrop.append(label.text!)
            } else{
                view.frame.origin = positions[view.tag-1]
                labelsInDrop = labelsInDrop.filter{$0 != label.text}
            }
        }
    }
    
    @objc func startTime(){
        time += 0.2
    }
    
    @objc func dismissButton(_ sender: Any){
        print("DISMISS")
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func helpButton(_ sender: Any){
        let webView = WebDocumentationViewController()
        webView.url = URL(string: self.challenge.resource_link)!
        present(webView, animated: false, completion: nil)
    }
    
    @objc func checkButton(_ sender: Any){
        
        timer.invalidate()
        print("TIME", time)
        self.timeSolved = time
        time = 0.0
        
        if labelsInDrop.containsSameElements(as: correctAnswer){
            print("CORRECT ANSWER")
            self.answerIsRight = true
            print("LABELS ARRAY", labelsInDrop)
            
            //Definir número de estrelas de acordo com o tempo
            if timeSolved <= timeTo3Stars {
                self.numberOfStars = 3
            } else if timeSolved <= timeTo2Stars && timeSolved > timeTo3Stars {
                self.numberOfStars = 2
            } else {
                self.numberOfStars = 1
            }
            
            showFeedback()
        }else{
            print("WRONG ANSWER")
            self.answerIsRight = false
            self.numberOfTries += 1
            
            if self.numberOfTries < 2 {
                UIView.animate(withDuration: TimeInterval(0), animations: { () -> Void in
                    self.progressView.setProgress(1.0, animated: true)
                })
                self.dragAndDrop.setTryAgainButton(tryAgainAction: #selector(setNextTry))
                print("LABELS ARRAY", labelsInDrop)
            }else{
                print("SHOW FEEDBACK")
                print("LABELS ARRAY", labelsInDrop)

                showFeedback()
            }

        }

    }
 
    func showFeedback(){
        self.numberOfTries = 0
        
        let stringUserAnswer = labelsInDrop.joined(separator: ",")
        let stringCorrectAnswer = correctAnswer.joined(separator: ",")
        
        let feedbackController = MultipleChoiceFeedbackViewController()
        feedbackController.getVariables(challenge: self.challenge, userAnswer: stringUserAnswer, correctAnswer: stringCorrectAnswer, answerIsRight: self.answerIsRight, numberOfStars: self.numberOfStars, timeSolved: self.timeSolved)
        
        print (">> SORT FEEDBACK VIEW\n")
        print (">> Usuario: \(String(describing: User.sharedInstance.email))")
        print (">> challenge ID: \(self.challenge.id)")
        print (">> stars: \(self.numberOfStars)")
        print (">> timeSolved: \(self.timeSolved)")
        
//        if (User.sharedInstance.email != nil) && (self.numberOfStars != nil) && (self.timeSolved != nil) {
//            userDAO.saveChallengeData(email: String(describing: User.sharedInstance.email), challenge_id: self.challenge.id, stars: self.numberOfStars, time: Int(self.timeSolved))
//            print ("Salvou no banco")
//        } else {
//            print ("Nao salvou no banco")
//        }
        
        present(feedbackController, animated: false, completion: nil)
    }
    
    
    @objc func setNextTry(){
        
        UIView.animate(withDuration: TimeInterval(self.challenge.estimatedTime), animations: { () -> Void in
            self.progressView.setProgress(0.0, animated: true)
        })

        //change buttons
        labelsInDrop = []
        self.dragAndDrop.tryAgainButton.removeFromSuperview()
        self.dragAndDrop.addSubview(self.dragAndDrop.checkButton)

        for i in 0...(labels.count-1){
            let label = labels[i]
            label.frame.origin = positions[i]
        }
        
        timer = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(startTime), userInfo: nil, repeats: true)
    }
 
 
}

extension Array where Element: Comparable {
    func containsSameElements(as other: [Element]) -> Bool {
        return self.count == other.count && self.sorted() == other.sorted()
    }
}


