//
//  ViewController.swift
//  be-swift
//
//  Created by Isabella Vieira on 08/10/17.
//  Copyright © 2017 Isabella Vieira. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

protocol LevelHandler {
    func getLevelData (level: Level, challengesView: CollectionChallengeView)
}

class ViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, LevelHandler {
    
    var challengesView: CollectionChallengeView!
    var arrayChallengeInfo = [UserChallengeInfo]()
    var arrayChallenges = [Challenge]()
    var user: User!
    var cellMenu: [UICollectionViewCell] = []
    var challengeClass: [Challenge] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.challengesView = CollectionChallengeView()
        self.view.addSubview(challengesView)
        self.view = self.challengesView
        
        print ("GET CHALLENGE")
        let levelDAO = LevelDAO()
        //getChallengesByLevel results are in the handler getLevelData
        levelDAO.getChallengesByLevel(handler: self, level: "level-1", challengesView: challengesView)
        
        self.challengesView.collectionChallenges1.dataSource = self
        self.challengesView.collectionChallenges1.delegate = self
        self.challengesView.collectionChallenges1.register(CollectionChallengesCell.self, forCellWithReuseIdentifier: "cell")
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.challengeClass.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = challengesView.collectionChallenges1.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath as IndexPath) as! CollectionChallengesCell
        
        
        if !self.challengeClass.isEmpty {
            let challenge = self.challengeClass[indexPath.row]
            let stars = 0
            let isLocked = false
            
            cell.configureCell(numberOfStars: stars, isLocked: isLocked, iconNumber: challenge.id)
            self.cellMenu.append(cell)
            return cell
        } else {
            print ("IS EMPTY")
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print ("apertou")
        let selectedChallenge = self.challengeClass[indexPath.row]
        
        if (selectedChallenge.mechanics == "MultipleChoice") {
            let multipleChoiceVC = MultipleChoiceController()
            //multipleChoiceVC.challenge = selectedChallenge
            multipleChoiceVC.resource_link = selectedChallenge.resource_link
            multipleChoiceVC.question = selectedChallenge.question
            multipleChoiceVC.exampleCode = selectedChallenge.exampleCode
            multipleChoiceVC.estimatedTime = selectedChallenge.estimatedTime
            multipleChoiceVC.options = selectedChallenge.options
            multipleChoiceVC.correctAnswer = selectedChallenge.correctAnswer[0] as! String
            multipleChoiceVC.feedbackAnswer = selectedChallenge.feedbackAnswer
            multipleChoiceVC.tag = selectedChallenge.tags[0] as! String
            present(multipleChoiceVC, animated: true, completion: nil)
            
        }
        
    }
    
    // This function gets the return of the Firebase asynchronous call and call the respective view
    func getLevelData(level: Level,  challengesView: CollectionChallengeView) {
        print ("HANDLER LEVEL ASSINCRONO")
        self.challengeClass = level.challenge
        DispatchQueue.main.async {
            challengesView.collectionChallenges1.reloadData()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}


