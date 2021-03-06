//
//  DragAndDropView.swift
//  be-swift
//
//  Created by Isabella Vieira on 08/10/17.
//  Copyright © 2017 Isabella Vieira. All rights reserved.
//

import Foundation
import UIKit

class DragAndDropView: View {
    
    var view = View(frame: CGRect.zero)
    var code: UILabel!
    var sizeView: CGFloat!
    var drop: UIImageView!
    var title: UILabel!
    var titles = [UILabel]()
    var yPostionTitle: CGFloat!
    var titleHeight: CGFloat!
    var checkButton: UIButton!
    var tryAgainButton: UIButton!
    var checkButtonFrame: CGRect!
    var count = 0
    var cells = 1
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
        convenience init (questionText: String, exampleCodeText: String?, options: [String], checkButtonAction: Selector){
        self.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 2000))
        
        let question = view.setQuestion(questionText: questionText)
        code = view.setExampleCode(exampleCodeText: exampleCodeText!, view: self)
        
        self.setDropView()
        self.setDragView(options: options)
        self.setCheckButton(checkButtonAction: checkButtonAction)
        let height = sizeView!
        self.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: height)
        
        self.addSubview(question)
        self.addSubview(code)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setDropView(){
        drop = UIImageView(name: "drop", frame: CGRect(x: 0, y: 0, width: 288, height: 103))
        
        let heightCode = code.frame.height
        let yPostionCode = code.frame.minY
        let distance = heightCode + yPostionCode
        
        let widhtiPhoneSE: CGFloat = 320
        let heightiPhoneSE: CGFloat = 568
        let screenSize = UIScreen.main.bounds
        let xScale = screenSize.width/widhtiPhoneSE
        let yScale = screenSize.height/heightiPhoneSE
        
        drop.frame.origin = CGPoint(x: 16*xScale, y: distance + 30*yScale)
        self.addSubview(drop)
    }
    
    func setDragView(options: [String]){
        
        let heightDrop = drop.frame.height
        let yPostionDrop = drop.frame.origin.y
        let distance = heightDrop + yPostionDrop
        
        let heightiPhoneSE: CGFloat = 568
        let screenSize = UIScreen.main.bounds
        let yScale = screenSize.height/heightiPhoneSE
        
        for option in options{
            title = UILabel(text: option, font: "SanFranciscoText-Medium", fontSize: 16, aligment: .center, textColor: UIColor.black, frame: CGRect(x: 21 + count, y: 20, width: 67, height: 39))
            if cells < 5{
                title.frame.origin = CGPoint(x: title.frame.origin.x, y: title.frame.origin.y + distance)
            }
            if cells >= 5{
                title.frame.origin = CGPoint(x: title.frame.origin.x, y: title.frame.origin.y + distance + 45*yScale)
            }
            count += 71
            if count == 284{
                count = 0
            }
            title.tag = cells
            title.backgroundColor = UIColor.white
            cells += 1
            self.addSubview(title)
            title.isUserInteractionEnabled = true
            titles.append(title)
            yPostionTitle = title.frame.origin.y
            titleHeight = title.frame.height
        }
    }
    
    func setCheckButton(checkButtonAction: Selector){
        checkButton = UIButton(image: "check", frame: CGRect(x: 0, y: 0, width: 288, height: 46), target: self)
        let distance = yPostionTitle + titleHeight
        checkButton.addTarget(target, action: checkButtonAction, for: UIControlEvents.touchUpInside)
        
        let widhtiPhoneSE: CGFloat = 320
        let heightiPhoneSE: CGFloat = 568
        let screenSize = UIScreen.main.bounds
        let xScale = screenSize.width/widhtiPhoneSE
        let yScale = screenSize.height/heightiPhoneSE
        
//        if distance < 568*yScale{
//            checkButton.frame.origin = CGPoint(x: 16*xScale, y: screenSize.height - 62*yScale)
//            sizeView = screenSize.height
//        } else {
            checkButton.frame.origin = CGPoint(x: 16*xScale, y: distance + 50*yScale)
            sizeView = checkButton.frame.origin.y + 140*yScale
//        }
        checkButtonFrame = checkButton.frame
        self.addSubview(checkButton)
    }

    func setTryAgainButton(tryAgainAction: Selector) {
        self.tryAgainButton = UIButton(image: "tryAgain", frame: CGRect(x: 0, y: 0, width: 288, height: 46), target: self)
        self.tryAgainButton.frame = checkButtonFrame
        self.checkButton.removeFromSuperview()
        self.addSubview(tryAgainButton)
        self.tryAgainButton.addTarget(target, action: tryAgainAction, for: .touchUpInside)
    }

}


