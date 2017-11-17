//
//  View.swift
//  be-swift
//
//  Created by Isabella Vieira on 08/10/17.
//  Copyright © 2017 Isabella Vieira. All rights reserved.
//

import Foundation
import UIKit

class View: UIView{
    
    var question: UILabel!
    var rectangleCode: CAShapeLayer!
    var exampleCodeLabel:UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(red:0.96, green:0.96, blue:0.96, alpha:1.0)
    }
    
    //Topo azul
    func setTopBar() -> CAShapeLayer{
        let rectangle = CAShapeLayer()
        rectangle.path = UIBezierPath(rect: UIScreen.changeScale(vector: CGRect(x: 0, y: 0, width: 320, height: 64))).cgPath
        rectangle.fillColor = UIColor(red:0.31, green:0.49, blue:0.95, alpha:1.0).cgColor
        
        return rectangle
    }
    
    //Titulo da pagina
    func setTitle(title: String) -> UILabel{
        return UILabel(text: title, font: "SanFranciscoText-Semibold", fontSize: 17, aligment: .center, textColor: UIColor.white, frame: CGRect(x: 0, y: 31, width: 320, height: 20))
    }
    
    //Botão de sair
    func setdismissButton(dismissButtonAction: Selector) -> UIButton{
        let dismissButton = UIButton(image: "exit", frame: CGRect(x: 0, y: 14, width: 50, height: 50), target: self)
        dismissButton.addTarget(target, action: dismissButtonAction, for: UIControlEvents.touchUpInside)
        
        return dismissButton
    }
    
    //Botão para documentação da Apple
    func setHelpButton(helpButtonAction: Selector) -> UIButton{
        let helpButton =  UIButton(image: "help", frame: CGRect(x: 266, y: 14, width: 50, height: 50), target: self)
        helpButton.addTarget(target, action: helpButtonAction, for: UIControlEvents.touchUpInside)
        
        return helpButton
    }
    
    //Pergunta da pagina
    func setQuestion(questionText: String) -> UILabel{
        question = UILabel(text: questionText, font: "SanFranciscoText-Medium", fontSize: 16, aligment: .left, textColor: UIColor(red:0.21, green:0.23, blue:0.47, alpha:1.0), frame: CGRect(x: 24, y: 78, width: 273, height: 300))
        let widhtiPhoneSE: CGFloat = 320
        let heightiPhoneSE: CGFloat = 568
        let screenSize = UIScreen.main.bounds
        let xScale = screenSize.width/widhtiPhoneSE
        let yScale = screenSize.height/heightiPhoneSE
        let height = heightForView(text: questionText, font: question.font, width: question.frame.width)
        question.frame = CGRect(x: 24*xScale, y: 78*yScale, width: 273*xScale, height: height)

        return question
    }
    
    //Codigo de exemplo da questão
    func setExempleCode(exampleCodeText: String, view: UIView) -> UILabel{
        
        let widhtiPhoneSE: CGFloat = 320
        let heightiPhoneSE: CGFloat = 568
        let screenSize = UIScreen.main.bounds
        let xScale = screenSize.width/widhtiPhoneSE
        let yScale = screenSize.height/heightiPhoneSE
        
        let heightQuestion = question.frame.height
        let exampleCode = UILabel(text: exampleCodeText, font: "SanFranciscoText-Medium", fontSize: 16, aligment: .left, textColor: UIColor.white, frame: CGRect(x: 24, y: heightQuestion, width: 273, height: 300))
        let height = heightForView(text: exampleCodeText, font: exampleCode.font, width: exampleCode.frame.width)
        exampleCode.frame = CGRect(x: 24*xScale, y: heightQuestion + 93*yScale, width: 273*xScale, height: height)
        labelDidChange(exampleCode)
        
        let yPosition = exampleCode.frame.minY
        let rectangleCode = CAShapeLayer()
        rectangleCode.path = UIBezierPath(roundedRect: CGRect(x: 13*xScale, y: yPosition - 2*yScale, width: 290*xScale, height: height + 8*yScale), cornerRadius: 10).cgPath

        rectangleCode.fillColor = UIColor(red:0.16, green:0.17, blue:0.21, alpha:1.0).cgColor
        rectangleCode.zPosition = -1
        if !exampleCodeText.isEmpty{
            view.layer.addSublayer(rectangleCode)
        }
        return exampleCode
    }
    
    func heightForView(text:String, font:UIFont, width:CGFloat) -> CGFloat{
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        label.sizeToFit()
        
        return label.frame.height
    }

    //Função para colorir caracteres
    func labelDidChange(_ label: UILabel) {
        let attrStr = NSMutableAttributedString(string: label.text!)
        let inputLength = attrStr.string.characters.count
        
        let searchString : NSArray = NSArray.init(objects: "func","var", "let", "if", "else", "return", "init", "true", "false", "class", "struct", "while", "case", "switch")
        for i in 0...searchString.count-1 {
            let string : String = searchString.object(at: i) as! String
            let searchLength = string.characters.count
            var range = NSRange(location: 0, length: attrStr.length)
            
            while (range.location != NSNotFound) {
                range = (attrStr.string as NSString).range(of: string, options: [], range: range)
                if (range.location != NSNotFound) {
                    attrStr.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor(red:0.76, green:0.20, blue:0.60, alpha:1.0), range: NSRange(location: range.location, length: searchLength))
                    range = NSRange(location: range.location + range.length, length: inputLength - (range.location + range.length))
                    label.attributedText = attrStr
                }
            }
        }
        
        let searchStringTypes : NSArray = NSArray.init(objects: "Int","Double", "String", "print")
        for i in 0...searchStringTypes.count-1 {
            let string : String = searchStringTypes.object(at: i) as! String
            let searchLength = string.characters.count
            var range = NSRange(location: 0, length: attrStr.length)
            while (range.location != NSNotFound) {
                range = (attrStr.string as NSString).range(of: string, options: [], range: range)
                if (range.location != NSNotFound) {
                    attrStr.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor(red:0.00, green:0.69, blue:0.79, alpha:1.0), range: NSRange(location: range.location, length: searchLength))
                    range = NSRange(location: range.location + range.length, length: inputLength - (range.location + range.length))
                    label.attributedText = attrStr
                }
            }
        }
        
        let searchInts : NSArray = NSArray.init(objects: "0","1", "2", "3", "4", "5", "6", "7", "8", "9")
        for i in 0...searchInts.count-1 {
            let string : String = searchInts.object(at: i) as! String
            let searchLength = string.characters.count
            var range = NSRange(location: 0, length: attrStr.length)
            while (range.location != NSNotFound) {
                range = (attrStr.string as NSString).range(of: string, options: [], range: range)
                if (range.location != NSNotFound) {
                    attrStr.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor(red:0.55, green:0.51, blue:0.81, alpha:1.0), range: NSRange(location: range.location, length: searchLength))
                    range = NSRange(location: range.location + range.length, length: inputLength - (range.location + range.length))
                    label.attributedText = attrStr
                }
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
