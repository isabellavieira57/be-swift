//
//  Label.swift
//  be-swift
//
//  Created by Mariana Meireles on 11/10/17.
//  Copyright © 2017 Isabella Vieira. All rights reserved.
//

import Foundation
import UIKit

public extension UILabel {
    
    convenience init(text: String, font: String, fontSize: CGFloat, aligment: NSTextAlignment, textColor: UIColor, frame: CGRect) {
        self.init(frame: UIScreen.changeScale(vector: frame))
        self.text = text
        self.textColor = textColor
        self.textAlignment = aligment
        self.numberOfLines = 0
        
        //fonte para diferentes devices
        let modelName = UIDevice.current.modelName
        
        if modelName == "iPhone 5" || modelName == "iPhone 5c" || modelName == "iPhone 5s" || modelName == "iPhone SE" {
            self.font = UIFont(name: font, size: fontSize)
        }
        else if modelName == "iPhone 6" || modelName == "iPhone 6s" || modelName == "iPhone 7" {
            self.font = UIFont(name: font, size: fontSize + 2.5)
        } else {
            self.font = UIFont(name: font, size: fontSize + 5)
        }    }
}
