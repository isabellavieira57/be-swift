//
//  TopView.swift
//  be-swift
//
//  Created by Mariana Meireles on 23/11/17.
//  Copyright © 2017 Isabella Vieira. All rights reserved.
//

import Foundation
import UIKit

class TopView: UIView {
    
    var view = View(frame: CGRect.zero)
    var yPosition: CGFloat!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init (progressView: UIProgressView, titleText: String, dismissButtonAction: Selector, helpButtonAction: Selector){
        self.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 2000))
        
        timeBar(progressView: progressView)
        setTopBar()
        setTitle(title: titleText)
        setdismissButton(dismissButtonAction: dismissButtonAction)
        setHelpButton(helpButtonAction: helpButtonAction)
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
    
    func setTitle(title: String){
        let title = UILabel(text: title, font: "SanFranciscoText-Semibold", fontSize: 17, aligment: .center, textColor: UIColor.white, frame: CGRect(x: 0, y: 31, width: 320, height: 20))
        
        self.addSubview(title)
    }
    
    func setdismissButton(dismissButtonAction: Selector){
        let dismissButton = UIButton(image: "exit", frame: CGRect(x: 0, y: 14, width: 50, height: 50), target: self)
        dismissButton.addTarget(target, action: dismissButtonAction, for: UIControlEvents.touchUpInside)
        dismissButton.isUserInteractionEnabled = true
        dismissButton.isEnabled = true
        self.addSubview(dismissButton)
    }
    
    func setHelpButton(helpButtonAction: Selector){
        let helpButton =  UIButton(image: "help", frame: CGRect(x: 266, y: 14, width: 50, height: 50), target: self)
        helpButton.addTarget(target, action: helpButtonAction, for: UIControlEvents.touchUpInside)
        
        self.addSubview(helpButton)
    }
    
    func timeBar(progressView: UIProgressView){
        let widhtiPhoneSE: CGFloat = 320
        let heightiPhoneSE: CGFloat = 568
        let screenSize = UIScreen.main.bounds
        let xScale = screenSize.width/widhtiPhoneSE
        let yScale = screenSize.height/heightiPhoneSE
        progressView.frame = CGRect(x: 0, y: 64*yScale, width: 320*xScale, height: 1)
        progressView.transform = progressView.transform.scaledBy(x: 1, y: 4*yScale)
        progressView.setProgress(1, animated: false)
        progressView.trackTintColor = UIColor(red:0.85, green:0.85, blue:0.85, alpha:1.0)
        progressView.tintColor = UIColor(red:0.00, green:0.92, blue:0.55, alpha:1.0)
        
        let yPositionProgess = progressView.frame.origin.y
        let height = progressView.frame.height
        yPosition = yPositionProgess + height
        
        self.addSubview(progressView)
    }
    
}
