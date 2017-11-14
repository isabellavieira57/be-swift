//
//  BlankFieldFeedbackView.swift
//  be-swift
//
//  Created by Ana Müller on 11/13/17.
//  Copyright © 2017 Isabella Vieira. All rights reserved.
//

import Foundation
import UIKit

class BlankFieldFeedbackView: FeedbackView
{

    override init(frame: CGRect)
    {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor(red:0.96, green:0.96, blue:0.96, alpha:1.0)
        
        
    }
    
//    convenience init (frame: CGRect, titleText: String, dismissButtonAction: Selector, helpButtonAction: Selector, questionText: String, exampleCodeText: String?, options: Array<String>, correctAnswer: Array<String>)
//    {
//        self.init(frame: frame)
//    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
