//
//  Textfield.swift
//  be-swift
//
//  Created by Mariana Meireles on 07/11/17.
//  Copyright © 2017 Isabella Vieira. All rights reserved.
//

import Foundation
import UIKit

public extension UITextField {
   
    convenience init(frame: CGRect, font: String, fontSize: CGFloat){
        self.init(frame: UIScreen.changeScale(vector: frame))
        self.backgroundColor = UIColor.white
        self.textColor = UIColor(red:0.16, green:0.17, blue:0.21, alpha:1.0)
        self.borderStyle = .roundedRect
        self.layer.masksToBounds = true
        self.layer.borderColor = UIColor(red:0.73, green:0.73, blue:0.73, alpha:1.0).cgColor
        self.layer.borderWidth = 1.0
        
        //fonte para diferentes devices
        let modelName = UIDevice.current.modelName
        
        if modelName == "iPhone 5" || modelName == "iPhone 5c" || modelName == "iPhone 5s" || modelName == "iPhone SE" {
            self.font = UIFont(name: font, size: fontSize)
            self.layer.cornerRadius = 18
        }
        else if modelName == "iPhone 6" || modelName == "iPhone 6s" || modelName == "iPhone 7" {
            self.font = UIFont(name: font, size: fontSize + 2.5)
            self.layer.cornerRadius = 20
        } else {
            self.font = UIFont(name: font, size: fontSize + 5)
            self.layer.cornerRadius = 22
        }
    }
}

