//
//  BlankFieldFeedbackViewController.swift
//  be-swift
//
//  Created by Ana Müller on 11/10/17.
//  Copyright © 2017 Isabella Vieira. All rights reserved.
//
import Foundation
import UIKit

class BlankFieldFeedbackViewController: FeedbackViewController
{
    var registerView: RegisterView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerView = RegisterView()
        self.view.addSubview(registerView)
    }
}
