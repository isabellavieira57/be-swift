//
//  TopView.swift
//  be-swift
//
//  Created by Mariana Meireles on 23/11/17.
//  Copyright © 2017 Isabella Vieira. All rights reserved.
//

import Foundation
import UIKit

class TopViewRegister: UIView {
    
    var view = View(frame: CGRect.zero)
    var yPosition: CGFloat!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init (goBackAction: Selector){
        self.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 2000))
        
        let heightiPhoneSE: CGFloat = 568
        let screenSize = UIScreen.main.bounds
        let yScale = screenSize.height/heightiPhoneSE
        
        yPosition = 64*yScale
        
        setTopBar()
        setTitle()
        setBackButton(goBackAction: goBackAction)
        self.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: yPosition)
        
        self.backgroundColor = UIColor.green
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setTopBar(){
        let rectangle = CAShapeLayer()
        rectangle.path = UIBezierPath(rect: UIScreen.changeScale(vector: CGRect(x: 0, y: 0, width: 320, height: 64))).cgPath
        rectangle.fillColor = UIColor(red:0.31, green:0.49, blue:0.95, alpha:1.0).cgColor
        
        self.layer.addSublayer(rectangle)
    }
    
    func setTitle(){
        let title = UILabel(text: "Sign up", font: "SanFranciscoText-Semibold", fontSize: 18, aligment: .center, textColor: UIColor.white, frame: CGRect(x: 0, y: 31, width: 320, height: 20))
        
        self.addSubview(title)
    }
    
    func setBackButton(goBackAction: Selector){
        let backButton = UIButton(image: "backButton", frame: CGRect(x: 12, y: 27, width: 14.29, height: 24), target: self)
        backButton.addTarget(target, action: goBackAction, for: .touchUpInside)
        backButton.isUserInteractionEnabled = true
        backButton.isEnabled = true
        self.addSubview(backButton)
    }
    
}

