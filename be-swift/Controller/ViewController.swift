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
     
        inicialView = View(frame: CGRect.zero, titleText: "Constants", dismissButtonAction: #selector(ViewController.dismissButton(_:)), helpButtonAction: #selector(ViewController.helpButton(_:)))
        
        blankField = BlankFieldView(frame: CGRect.zero, questionText: "Once this code is executed, how \nmany items will numbers contain?")
        
        self.view.addSubview(blankField)
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

