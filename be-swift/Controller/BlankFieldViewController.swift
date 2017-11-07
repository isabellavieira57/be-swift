//
//  BlankFieldViewController.swift
//  be-swift
//
//  Created by Mariana Meireles on 25/10/17.
//  Copyright © 2017 Isabella Vieira. All rights reserved.
//

import Foundation
import UIKit

class BlankFieldViewController: UIViewController {
    
    var blankField: BlankFieldView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        blankField = BlankFieldView(frame: self.view.bounds, titleText: "Constants", dismissButtonAction: #selector(BlankFieldViewController.dismissButton(_:)), helpButtonAction: #selector(BlankFieldViewController.helpButton(_:)), questionText: "Once this code is executed, how \n1 many items will numbers contain? \n2 many items will numbers contain? \n3 many items will numbers contain? \n4 many items will numbers contain? \n5 many items will numbers contain? \n6 many items will numbers contain?", exampleCodeText: "func calculateDiscount (age: Int, \nprice: Double, discount: Double) \n->  Double { \nvar value = 0.0 \nif (age>60 || age<10) { ")
        
        self.view.addSubview(blankField)
    }
    
    @objc func dismissButton(_ sender: Any){
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func helpButton(_ sender: Any){
        let webView = WebDocumentationViewController()
        webView.url = URL(string: "https://stackoverflow.com/")!
        present(webView, animated: false, completion: nil)
    }
    
}
