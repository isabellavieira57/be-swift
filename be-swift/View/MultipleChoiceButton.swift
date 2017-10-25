//
//  MultipleChoiceButton.swift
//  be-swift
//
//  Created by Ana Müller on 10/24/17.
//  Copyright © 2017 Isabella Vieira. All rights reserved.
//

import UIKit

class MultipleChoiceButton : UIButton {
    
    var myAlternateButton: Array<MultipleChoiceButton>!
    
    var multipleChoiceImage:String? = "selectedOption2.png"{
    
        didSet{

            if multipleChoiceImage != nil {

                self.setImage(UIImage(named: multipleChoiceImage!), for: UIControlState.selected)
            }
        }
    }

    func unselectAlternateButtons(){
        
        if myAlternateButton != nil {
            
            self.isSelected = true
            
            for aButton:MultipleChoiceButton in myAlternateButton! {
                
                aButton.isSelected = false
            }
            
        }else{
            
            toggleButton()
        }
    }
    
    func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        
        unselectAlternateButtons()
        super.touchesBegan(touches as! Set<UITouch>, with: event)
    }
    
    func toggleButton(){
        
        if self.isSelected==false{
            
            self.isSelected = true
        } else {
            
            self.isSelected = false
        }
    }
}
