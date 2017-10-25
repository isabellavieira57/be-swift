//
//  MultipleChoiceController.swift
//  be-swift
//
//  Created by Ana Müller on 10/23/17.
//  Copyright © 2017 Isabella Vieira. All rights reserved.
//

import UIKit

class MultipleChoiceController: UIViewController {//, SSRadioButtonControllerDelegate {
    
    var multipleChoiceView: MultipleChoiceView!
    
//    var radioButtonController: SSRadioButtonsController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        multipleChoiceView = MultipleChoiceView()
        
        self.view.addSubview(multipleChoiceView)
        self.view = self.multipleChoiceView
        
//        radioButtonController = SSRadioButtonsController(buttons: multipleChoiceView.optionButton1, multipleChoiceView.optionButton2, multipleChoiceView.optionButton3, multipleChoiceView.optionButton4)
//
//        radioButtonController!.delegate = self
//        radioButtonController!.shouldLetDeSelect = true
        
    }
    
//    func didSelectButton(selectedButton: UIButton?)
//    {
//        NSLog(" \(selectedButton)" )
//        selectedButton?.setImage(UIImage(named: "selectedOption2"), for: .selected)
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}
