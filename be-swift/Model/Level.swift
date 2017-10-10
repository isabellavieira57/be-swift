//
//  Level.swift
//  be-swift
//
//  Created by Isabella Vieira on 08/10/17.
//  Copyright © 2017 Isabella Vieira. All rights reserved.
//

import Foundation

class Level {
    
    var star: Int
    var level: String
    var xp: Int
    
    init (star: Int, level: String, xp: Int) {
        self.star = star
        self.level = level
        self.xp = xp
    }
}
