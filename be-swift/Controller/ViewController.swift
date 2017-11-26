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
    func getUserChallengeInfo(userChallengeInfo: [UserChallengeInfo])
}

class ViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, LevelHandler {
    
    var challengesView: CollectionChallengeView!
    var userChallengeInfo = [UserChallengeInfo]()
    var arrayChallenges = [Challenge]()
    var user: User!
    var cellMenu: [UICollectionViewCell] = []
    var challengeData: [Challenge] = []
//    var notification: LocalNotificationCenter!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //TODO: Contabilizar total de estrelas por usuário e passar pelo parâmetro
        self.challengesView = CollectionChallengeView(numberOfStarsTotal: setStarsNumber(numberOfStarsTotal: 6))
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
        
        let userID : String = (Auth.auth().currentUser?.email)!
        print ("userID: ", userID)

        let userDAO = UserDAO()
        userDAO.getChallengeInfoByUser(handler: self, email: userID as String!)
        
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
    
    func getUserChallengeInfo(userChallengeInfo: [UserChallengeInfo]) {
        self.userChallengeInfo = userChallengeInfo
        DispatchQueue.main.async {
            self.challengesView.collectionChallenges1.reloadData()
            print (" >>> DADOS DOS CHALLENGES POR USUARIO: ", self.userChallengeInfo)

        }
    }
    
    func setStarsNumber(numberOfStarsTotal: Int) -> String {
        var starString: String!
        
        if numberOfStarsTotal < 10 {
            starString = "00" + String(numberOfStarsTotal)
        } else {
            starString = "0" + String(numberOfStarsTotal)
        }
        return starString
    }
    
    @objc func logOut()
    {
        User.sharedInstance.logout()
        let controller = WelcomeViewController()
        present(controller, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

