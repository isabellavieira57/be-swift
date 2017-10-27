//
//  SSRadioButton.swift
//  SampleProject
//
//  Created by Shamas on 18/05/2015.
//  Copyright (c) 2015 Al Shamas Tufail. All rights reserved.
//  with circle stroke attribute

import Foundation
import UIKit

class SSRadioButton: UIButton {
    
    var optionLabel: UILabel!
    
    override var isSelected: Bool {
        didSet {
            toggleButon()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    fileprivate func initialize() {
        
        self.optionLabel = UILabel(frame: CGRect(x: bounds.width*0.14, y: 0.0, width: bounds.width*0.84, height: bounds.height))
        self.optionLabel.font = UIFont(name: "SanFranciscoText-Medium", size: 16)
        self.optionLabel.center.y = bounds.height/2.2
        self.optionLabel.textColor = UIColor(red:0.21, green:0.23, blue:0.47, alpha:1.0)
        self.setBackgroundImage(UIImage(named:"defaultOption"), for: .normal)
        
        self.addSubview(optionLabel)
        
        self.toggleButon()
    }
    /**
     Toggles selected state of the button.
     */
    func toggleButon() {
        if self.isSelected {
            self.setBackgroundImage(UIImage(named:"selectedOption"), for: .selected)
            
        } else {
            self.setBackgroundImage(UIImage(named:"defaultOption"), for: .normal)
            
        }
    }
    
    override func prepareForInterfaceBuilder() {
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
}
