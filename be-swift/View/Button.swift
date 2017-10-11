//
//  Button.swift
//  be-swift
//
//  Created by Mariana Meireles on 11/10/17.
//  Copyright © 2017 Isabella Vieira. All rights reserved.
//

import Foundation
import UIKit

extension UIButton{
    
    convenience init(image: String, frame: CGRect, target: Any?, action: Selector) {
        self.init(type: .system)
        self.frame = UIScreen.changeScale(vector: frame)
        let image = UIImage(named: image) as UIImage?
        self.setBackgroundImage(image, for: .normal)
        self.addTarget(target, action: action, for: UIControlEvents.touchUpInside)
    }
}
