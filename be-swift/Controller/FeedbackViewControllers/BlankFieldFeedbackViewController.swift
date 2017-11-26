//
//  BlankFieldFeedbackViewController.swift
//  be-swift
//
//  Created by Ana Müller on 11/10/17.
//  Copyright © 2017 Isabella Vieira. All rights reserved.
//
import Foundation
import UIKit
import Firebase

class BlankFieldFeedbackViewController: FeedbackViewController
{
    var registerView: RegisterView!
    var userDAO = UserDAO()


    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerView = RegisterView()
        self.view.addSubview(registerView)
        
//        let userID : String = (Auth.auth().currentUser?.email)!
//        print ("userID: ", userID)
        
        //userDAO.saveChallengeData(email: userID, challenge_id: self.challenge.id, stars: self.numberOfStars!, time: self.timeSolved!)
        
    }
}
