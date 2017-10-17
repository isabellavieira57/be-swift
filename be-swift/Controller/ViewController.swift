//
//  ViewController.swift
//  be-swift
//
//  Created by Isabella Vieira on 08/10/17.
//  Copyright © 2017 Isabella Vieira. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var inicialView: View!
    var blankField: BlankFieldView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        inicialView = View(frame: CGRect.zero, titleText: "Constants", dismissButtonAction: #selector(ViewController.dismissButton(_:)), helpButtonAction: #selector(ViewController.helpButton(_:)), questionText: "Once this code is executed, how \nmany items will numbers contain? \nmany items will numbers contain? \nmany items will numbers contain? \nmany items will numbers contain?", haveExampleCode: true, exampleCodeText: "func calculateDiscount (age: Int, \nprice: Double, discount: Double) \n->  Double { \nvar value = 0.0 \nif (age>60 || age<10) { \nvalue = price - (price * \ndiscount) \n} else { \nvalue = price \n} \nreturn value \n} \nvar age = 5")
        
//        blankField = BlankFieldView(frame: CGRect.zero, questionText: "Once this code is executed, how \nmany items will numbers contain?")
        
//        self.view.addSubview(blankField)
        self.view.addSubview(inicialView)
        }
    
    @objc func dismissButton(_ sender: Any){
        //mandar para a home
    }
    
    @objc func helpButton(_ sender: Any){
        //mandar para doc apple
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

