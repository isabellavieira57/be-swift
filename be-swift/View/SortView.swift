//
//  SortView.swift
//  be-swift
//
//  Created by Isabella Vieira on 08/10/17.
//  Copyright © 2017 Isabella Vieira. All rights reserved.
//

import Foundation
import UIKit

class SortView: View {
    
    var sortTableView: UITableView!
    var background: UIImageView!
    var sortViewController = SortViewController()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.lightGray
        
        var numberOfLines = sortViewController.arrayOptions.count
        
        var screenHeight = UIScreen.main.bounds.height
        var screenWidth = UIScreen.main.bounds.width
        
        self.sortTableView = UITableView(frame: CGRect(x: 5, y: 50, width: screenWidth - 10, height: 44 * CGFloat(numberOfLines)))
        self.sortTableView.separatorStyle = .none
        self.sortTableView.backgroundColor = UIColor.lightGray
        
        self.background = UIImageView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight))
        self.background.backgroundColor = UIColor.lightGray
        
        self.addSubview(background)
        self.addSubview(sortTableView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
