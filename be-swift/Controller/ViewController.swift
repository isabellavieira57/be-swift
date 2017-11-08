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
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = challengesView.collectionChallenges1.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath as IndexPath) as! CollectionChallengesCell
        
        let arrayNumbers = [1,2,3,4,5,6,7,8,9,10,11,12]
        
        let stars = 0
        let isLocked = false
        let number = arrayNumbers[indexPath.item]
        //        let stars = self.arrayChallengeInfo[indexPath.item].starChallenge
        
        cell.configureCell(numberOfStars: stars, isLocked: isLocked, iconNumber: number)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
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
       //present(nextController, animated: true, completion: nil)
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
        
        for challenge in level.challenge {
            //print (">>>>> question: \(challenge.question)")
            
            if (challenge.mechanics == "MultipleChoice") {
                let multipleChoiceVC = MultipleChoiceController()
                multipleChoiceVC.resource_link = challenge.resource_link
                multipleChoiceVC.question = challenge.question
                multipleChoiceVC.exampleCode = challenge.exampleCode
                multipleChoiceVC.estimatedTime = challenge.estimatedTime
                multipleChoiceVC.options = challenge.options
                multipleChoiceVC.correctAnswer = challenge.correctAnswer[0] as! String
                multipleChoiceVC.feedbackAnswer = challenge.feedbackAnswer
                multipleChoiceVC.tag = challenge.tags[0] as! String
                //present(multipleChoiceVC, animated: true, completion: nil)
                //challengesView.collectionChallenges1.selectItem(at: IndexPath(index: challenge.id), animated: true, scrollPosition: UICollectionViewScrollPosition(rawValue: 0))
            } else if (challenge.mechanics == "DragAndDrop") {
                // TODO: Build view for drag and drop
            } else if (challenge.mechanics == "BlankField") {
                let blankFieldVC = BlankFieldViewController()
                blankFieldVC.resource_link = challenge.resource_link
                blankFieldVC.question = challenge.question
                blankFieldVC.exampleCode = challenge.exampleCode
                blankFieldVC.estimatedTime = challenge.estimatedTime
                blankFieldVC.options = challenge.options
                blankFieldVC.correctAnswer = challenge.correctAnswer
                blankFieldVC.feedbackAnswer = challenge.feedbackAnswer
                blankFieldVC.tag = challenge.tags[0] as! String
                present(blankFieldVC, animated: true, completion: nil)
            } else if (challenge.mechanics == "FillTheGap") {
                // TODO: Build view for fill the gap
            } else if (challenge.mechanics == "Sort") {
                let sortVC = SortViewController()
                sortVC.resource_link = challenge.resource_link
                sortVC.question = challenge.question
                sortVC.exampleCode = challenge.exampleCode
                sortVC.estimatedTime = challenge.estimatedTime
                sortVC.options = challenge.options
                sortVC.correctAnswer = challenge.correctAnswer
                sortVC.feedbackAnswer = challenge.feedbackAnswer
                sortVC.tag = challenge.tags[0] as! String
                //present(sortVC, animated: true, completion: nil)
            } else {
                print ("ERROR: Mechanics not found!")
            }
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

