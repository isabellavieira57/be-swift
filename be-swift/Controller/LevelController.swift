////
////  LevelController.swift
////  be-swift
////
////  Created by Isabella Vieira on 05/11/17.
////  Copyright © 2017 Isabella Vieira. All rights reserved.
////
//
//import Foundation
//import Firebase
//import FirebaseDatabase
//
//
//protocol LevelHandler {
//    func getLevelData (level: Level)
//}
//
//class LevelController: UIViewController, LevelHandler {
//
//    override func viewDidLoad() {
//        print (">>> VIEW DID LOAD LEVEL CONTROLLER <<<")
//        //super.viewDidLoad()
//        self.getChallenge()
//    }
//
//    func getChallenge () {
//        print ("GET CHALLENGE")
//        let levelDAO = LevelDAO()
//
//        //getChallengesByLevel results are in the handler getLevelData
//        levelDAO.getChallengesByLevel(handler: self, level: "level-1")
//    }
//
//    // This function gets the return of the Firebase asynchronous call and call the respective view
//    func getLevelData(level: Level) {
//        print ("HANDLER LEVEL ASSINCRONO")
//
//        for challenge in level.challenge {
//            //print (">>>>> question: \(challenge.question)")
//
//            if (challenge.mechanics == "MultipleChoice") {
//                // TODO: Build view for multiple choice
//            } else if (challenge.mechanics == "DragAndDrop") {
//                // TODO: Build view for drag and drop
//            } else if (challenge.mechanics == "BlankField") {
//                // TODO: Build view for blank field
//            } else if (challenge.mechanics == "FillTheGap") {
//                // TODO: Build view for fill the gap
//            } else if (challenge.mechanics == "Sort") {
//                // TODO: Build view for sort
//            } else {
//                print ("ERROR: Mechanics not found!")
//            }
//
//        }
//    }
//
//
//
//    func selectView () -> Void {
//
//    }
//
//
//
//    func updateUserChallengeInfo () -> Void {
//
//    }
//
//
//
//    func updateXpTotal () -> Void {
//
//    }
//
//    func updateStarTotal () -> Void {
//
//    }
//
//    func updateXpChallenge () -> Void {
//
//    }
//
//    func updateStarChallenge () -> Void {
//
//    }
//
//    func verifyUserAnswer () -> Void {
//
//    }
//}

