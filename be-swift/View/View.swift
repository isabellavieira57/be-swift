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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(frame: CGRect, titleText: String, dismissButtonAction: Selector, helpButtonAction: Selector){
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

        
        self.layer.addSublayer(rectangle)
        self.addSubview(title)
        self.addSubview(dismissButton)
        self.addSubview(helpButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
    
//        view.backgroundColor = UIColor(red:0.96, green:0.96, blue:0.96, alpha:1.0)



