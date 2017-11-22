//
//  Image.swift
//  be-swift
//
//  Created by Mariana Meireles on 21/11/17.
//  Copyright © 2017 Isabella Vieira. All rights reserved.
//

import Foundation
import UIKit

public extension UIImageView {
    
    convenience init(name: String, frame: CGRect) {
        self.init(image: UIImage(named: name))
        self.frame = UIScreen.changeScale(vector: frame)
    }
}
