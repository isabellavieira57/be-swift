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
    var challengeData: [Challenge] = []
//    var notification: LocalNotificationCenter!

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
   
//        notification.localNotification(title: "Be Swift", body: "It's time to practice!")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.challengeData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = challengesView.collectionChallenges1.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath as IndexPath) as! CollectionChallengesCell
        
        if !self.challengeData.isEmpty {
            let challenge = self.challengeData[indexPath.row]
            var stars = 0
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
        let selectedChallenge = self.challengeData[indexPath.row]
        switch selectedChallenge.mechanics{
        case "MultipleChoice":
            let multipleChoiceVC = MultipleChoiceController()
            multipleChoiceVC.challenge = selectedChallenge
            present(multipleChoiceVC, animated: true, completion: nil)
        case "Sort":
            let sortVC = SortViewController()
            sortVC.challenge = selectedChallenge
            present(sortVC, animated: true, completion: nil)
        case "BlankField":
            let blankFieldVC = BlankFieldViewController()
            blankFieldVC.challenge = selectedChallenge
            present(blankFieldVC, animated: true, completion: nil)
        case "DragAndDrop":
            let dragAndDropVC = DragAndDropViewController()
            dragAndDropVC.challenge = selectedChallenge
            present(dragAndDropVC, animated: true, completion: nil)
        default:
            print("No mechanics found!")
        }
    }
    
    // This function gets the return of the Firebase asynchronous call and call the respective view
    func getLevelData(level: Level,  challengesView: CollectionChallengeView) {
        self.challengeData = level.challenge.sorted(by: { $0.id < $1.id})
        DispatchQueue.main.async {
            challengesView.collectionChallenges1.reloadData()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

