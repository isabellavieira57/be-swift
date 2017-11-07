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

class ViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    var challengesView: CollectionChallengeView!
    var arrayChallengeInfo = [UserChallengeInfo]()
    var arrayChallenges = [Challenge]()
    var user: User!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.challengesView = CollectionChallengeView()
        self.view.addSubview(challengesView)
        self.view = self.challengesView
        
        self.challengesView.collectionChallenges1.dataSource = self
        self.challengesView.collectionChallenges1.delegate = self
        self.challengesView.collectionChallenges1.register(CollectionChallengesCell.self, forCellWithReuseIdentifier: "cell")
        
//        self.challengesView.starLabel.text = user.starTotal
//        self.challengesView.xpLabel.text = user.xpTotal
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = challengesView.collectionChallenges1.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath as IndexPath) as! CollectionChallengesCell
        
        let stars = 2
        let isLocked = false
        let number = indexPath.count
        //        let stars = self.arrayChallengeInfo[indexPath.item].starChallenge
        
        cell.configureCell(numberOfStars: stars, isLocked: isLocked, iconNumber: number)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        var mechanics = "MultipleChoice"
//        var mechanics = self.arrayChallenges[indexPath.item].mechanics
        var nextController: UIViewController!
        
//        if arrayChallengeInfo id = self.arrayChallenges[indexPath.item].challengeID {
        
        switch mechanics 
      {
       case "BlankField":
             nextController = BlankFieldController()
        //        case "DragAndDrop":
        //            nextController = DragAndDropController()
        case "MultipleChoice":
            nextController = MultipleChoiceController()
        case "Sort":
            nextController = SortViewController()
        //        case "FillTheGap":
        //            nextController = FillTheGapController()
        default:
            nextController = self
        }
        
        present(nextController, animated: true, completion: nil)
//        }
    }
        
//    override func viewDidAppear(_ animated: Bool) {
//        let controller = BlankFieldViewController()
//        present(controller, animated: false, completion: nil)
//        
//        let levelController = LevelController()
//        levelController.viewDidLoad()
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

