//
//  BlankFieldView.swift
//  be-swift
//
//  Created by Isabella Vieira on 08/10/17.
//  Copyright © 2017 Isabella Vieira. All rights reserved.
//

import Foundation
import UIKit

class BlankFieldView: View {
    
    var question = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

    }

    convenience init(frame: CGRect, questionText: String){
        self.init(frame: frame)
        
        //Questão da pagina
        question = UILabel(text: questionText, font: "SanFranciscoText-Medium", fontSize: 16, aligment: .left, textColor: UIColor(red:0.21, green:0.23, blue:0.47, alpha:1.0), frame: CGRect(x: 24, y: 84, width: 273, height: 300))

        self.addSubview(question)
        updateLabelFrame()

    }

    func updateLabelFrame() {
        let maxSize = CGSize(width: 273, height: 300)
        let size = question.sizeThatFits(maxSize)
        question.frame = CGRect(origin: CGPoint(x: 24, y: 84), size: size)
        print(question.frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
