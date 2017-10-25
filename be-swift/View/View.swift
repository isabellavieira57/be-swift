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
    
    private var question = UILabel()
    private var exampleCode = UILabel()
    private let rectangleCode = CAShapeLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(frame: CGRect, titleText: String, dismissButtonAction: Selector, helpButtonAction: Selector, questionText: String, haveExampleCode: Bool, exampleCodeText: String?){
        self.init(frame: frame)

        //Topo azul
        let rectangle = CAShapeLayer()
        rectangle.path = UIBezierPath(rect: UIScreen.changeScale(vector: CGRect(x: 0, y: 0, width: 321, height: 64))).cgPath
        rectangle.fillColor = UIColor(red:0.31, green:0.49, blue:0.95, alpha:1.0).cgColor
        
        //Titulo da pagina
        let title = UILabel(text: titleText, font: "SanFranciscoText-Semibold", fontSize: 17, aligment: .center, textColor: UIColor.white, frame: CGRect(x: 0, y: 31, width: 320, height: 20))
        
        //Botão de sair
        let dismissButton = UIButton(image: "exit", frame: CGRect(x: 0, y: 14, width: 50, height: 50), target: self, action: dismissButtonAction)
        
        //Botão para documentação da Apple
        let helpButton = UIButton(image: "help", frame: CGRect(x: 266, y: 14, width: 50, height: 50), target: self, action: helpButtonAction)
        
        //Pergunta da pagina
        question = UILabel(text: questionText, font: "SanFranciscoText-Medium", fontSize: 16, aligment: .left, textColor: UIColor(red:0.21, green:0.23, blue:0.47, alpha:1.0), frame: CGRect(x: 24, y: 84, width: 273, height: 300))
        
        //Codigo de exemplo da questão
        if haveExampleCode == true{
            exampleCode = UILabel(text: exampleCodeText!, font: "SanFranciscoText-Medium", fontSize: 16, aligment: .left, textColor: UIColor.white, frame: CGRect(x: 16, y: 273, width: 288, height: 300))
            labelDidChange(exampleCode)
            self.addSubview(exampleCode)
            
            rectangleCode.path = UIBezierPath(roundedRect: UIScreen.changeScale(vector: CGRect(x: 16, y: 135, width: 288, height: 57)), cornerRadius: 10).cgPath
            rectangleCode.fillColor = UIColor(red:0.16, green:0.17, blue:0.21, alpha:1.0).cgColor
            rectangleCode.zPosition = -1
            self.layer.addSublayer(rectangleCode)
            
        }

        self.layer.addSublayer(rectangle)
        self.addSubview(title)
        self.addSubview(dismissButton)
        self.addSubview(helpButton)
        self.addSubview(question)
        
        updateFrame()
    }
    
    //Função para atualizar altura da label e posição do shape cinza
    private func updateFrame() {
        let maxSize = CGSize(width: 273, height: 300)
        let size = question.sizeThatFits(maxSize)
        let size2 = exampleCode.sizeThatFits(maxSize)
        question.frame = CGRect(origin: CGPoint(x: 24, y: 84), size: size)
        exampleCode.frame = CGRect(origin: CGPoint(x: 24, y: question.frame.height + 100), size: size2)
        rectangleCode.path = UIBezierPath(roundedRect: UIScreen.changeScale(vector: CGRect(x: 16, y: exampleCode.frame.minY - 5, width: 288, height: exampleCode.frame.height + 15)), cornerRadius: 10).cgPath
    }
    
    //Função para colorir caracteres
    func labelDidChange(_ label: UILabel) {
        let attrStr = NSMutableAttributedString(string: label.text!)
        let inputLength = attrStr.string.characters.count
        
        let searchString : NSArray = NSArray.init(objects: "func","var", "let", "if", "else", "return")
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
    
//        view.backgroundColor = UIColor(red:0.96, green:0.96, blue:0.96, alpha:1.0)



