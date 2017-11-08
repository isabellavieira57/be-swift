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
            //var cellNumber = arrayNumbers[indexPath.item]
            //        let stars = self.arrayChallengeInfo[indexPath.item].starChallenge
            
            cell.configureCell(numberOfStars: stars, isLocked: isLocked, iconNumber: challenge.id)
            self.cellMenu.append(cell)
            return cell
        } else {
            print ("IS EMPTY")
        }
        
        return cell
        
        //var arrayNumbers = [1,2,3,4,5,6,7,8,9,10,11,12]
        
       
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

        
        
//        var mechanics = "MultipleChoice"
////        var mechanics = self.arrayChallenges[indexPath.item].mechanics
//        var nextController: UIViewController!
//
////        if arrayChallengeInfo id = self.arrayChallenges[indexPath.item].challengeID {
//
//        switch mechanics
//      {
//       case "BlankField":
//             nextController = BlankFieldViewController()
//        //        case "DragAndDrop":
//        //            nextController = DragAndDropController()
//        case "MultipleChoice":
//            nextController = MultipleChoiceController()
//        case "Sort":
//            nextController = SortViewController()
//        //        case "FillTheGap":
//        //            nextController = FillTheGapController()
//        default:
//            nextController = self
//        }
//
       //present(controller, animated: true, completion: nil)
////        }
    }
//
//    override func viewDidAppear(_ animated: Bool) {
//    }

    //    @objc func dismissButton(_ sender: Any){
    //
    //    }
    //
    //    @objc func helpButton(_ sender: Any){
    //        //mandar para doc apple
    //        let webView = WebDocumentationViewController()
    //        present(webView, animated: false, completion: nil)
    //    }
    
    // This function gets the return of the Firebase asynchronous call and call the respective view
    func getLevelData(level: Level,  challengesView: CollectionChallengeView) {
        print ("HANDLER LEVEL ASSINCRONO")
        self.challengeClass = level.challenge
        
        DispatchQueue.main.async {
            challengesView.collectionChallenges1.reloadData()
        }
        
        
//        for challenge in level.challenge {
//
//
//            print (">>>>> question: \(challenge.id)")
//            //self.number.append(challenge.id)
//
//            if (challenge.mechanics == "MultipleChoice") {
//                let multipleChoiceVC = MultipleChoiceController()
//                multipleChoiceVC.resource_link = challenge.resource_link
//                multipleChoiceVC.question = challenge.question
//                multipleChoiceVC.exampleCode = challenge.exampleCode
//                multipleChoiceVC.estimatedTime = challenge.estimatedTime
//                multipleChoiceVC.options = challenge.options
//                multipleChoiceVC.correctAnswer = challenge.correctAnswer[0] as! String
//                multipleChoiceVC.feedbackAnswer = challenge.feedbackAnswer
//                multipleChoiceVC.tag = challenge.tags[0] as! String
//                //present(multipleChoiceVC, animated: true, completion: nil)
//                //challengesView.collectionChallenges1.selectItem(at: IndexPath(index: challenge.id), animated: true, scrollPosition: UICollectionViewScrollPosition(rawValue: 0))
//                //collectionView(challengesView.collectionChallenges1, didSelectItemAt: IndexPath(index: 1), controller: multipleChoiceVC)
//                //present(multipleChoiceVC, animated: true, completion: nil)
//            } else if (challenge.mechanics == "DragAndDrop") {
//                // TODO: Build view for drag and drop
//            } else if (challenge.mechanics == "BlankField") {
//                let blankFieldVC = BlankFieldViewController()
//                blankFieldVC.resource_link = challenge.resource_link
//                blankFieldVC.question = challenge.question
//                blankFieldVC.exampleCode = challenge.exampleCode
//                blankFieldVC.estimatedTime = challenge.estimatedTime
//                blankFieldVC.options = challenge.options
//                blankFieldVC.correctAnswer = challenge.correctAnswer
//                blankFieldVC.feedbackAnswer = challenge.feedbackAnswer
//                blankFieldVC.tag = challenge.tags[0] as! String
//                //present(blankFieldVC, animated: true, completion: nil)
//            } else if (challenge.mechanics == "FillTheGap") {
//                // TODO: Build view for fill the gap
//            } else if (challenge.mechanics == "Sort") {
//                let sortVC = SortViewController()
//                sortVC.resource_link = challenge.resource_link
//                sortVC.question = challenge.question
//                sortVC.exampleCode = challenge.exampleCode
//                sortVC.estimatedTime = challenge.estimatedTime
//                sortVC.options = challenge.options
//                sortVC.correctAnswer = challenge.correctAnswer
//                sortVC.feedbackAnswer = challenge.feedbackAnswer
//                sortVC.tag = challenge.tags[0] as! String
//                //present(sortVC, animated: true, completion: nil)
//            } else {
//                print ("ERROR: Mechanics not found!")
//            }
//
//        }
        //print("CELL MENU \(self.cellMenu.)")
//        switch cellMenu{
//        case 1:
//
//
//        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

