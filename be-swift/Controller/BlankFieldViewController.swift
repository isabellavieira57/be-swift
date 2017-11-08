//
//  BlankFieldViewController.swift
//  be-swift
//
//  Created by Mariana Meireles on 25/10/17.
//  Copyright © 2017 Isabella Vieira. All rights reserved.
//

import Foundation
import UIKit

class BlankFieldViewController: UIViewController, UITextFieldDelegate {
    
    var blankField: BlankFieldView!
    var scrollView: UIScrollView!
    var challenge: Challenge!
    
//    var id: Int = 0
//    var resource_link: String = ""
//    var question: String = ""
//    var exampleCode: String = ""
//    var estimatedTime: Int = 0
//    var mechanics: String = ""
//    var options: NSArray = []
//    var correctAnswer: NSArray = []
//    var feedbackAnswer: String = ""
//    var tag: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        blankField = BlankFieldView(titleText: self.challenge.tags[0] as! String, dismissButtonAction: #selector(BlankFieldViewController.dismissButton(_:)), helpButtonAction: #selector(BlankFieldViewController.helpButton(_:)), questionText: self.challenge.question, exampleCodeText: self.challenge.exampleCode, checkButtonAction:#selector(BlankFieldViewController.checkButton(_:)), currentView: self)
        
//        blankField = BlankFieldView(titleText: "Constants", dismissButtonAction: #selector(BlankFieldViewController.dismissButton(_:)), helpButtonAction: #selector(BlankFieldViewController.helpButton(_:)), questionText: "Once this code is executed, how \n1 many items will numbers contain? \n2 many items will numbers contain? \n3 many items will numbers contain? \n4 many items will numbers contain? \n5 many items will numbers contain? \n6 many items will numbers contain?", exampleCodeText: "func calculateDiscount (age: Int, \nprice: Double, discount: Double) \n->  Double { \nvar value = 0.0 \nif (age>60 || age<10) { ", checkButtonAction:#selector(BlankFieldViewController.checkButton(_:)), currentView: self)
        
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        scrollView.contentSize = CGSize(width: self.view.frame.size.width, height: blankField.frame.height)
        self.view.addSubview(scrollView)
        scrollView.addSubview(blankField)
    }
    
    @objc func dismissButton(_ sender: Any){
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func helpButton(_ sender: Any){
        let webView = WebDocumentationViewController()
        webView.url = URL(string: "https://stackoverflow.com/")!
        present(webView, animated: false, completion: nil)
    }
    
    @objc func checkButton(_ sender: Any){
        print("CHECK")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let heightiPhoneSE: CGFloat = 568
        let screenSize = UIScreen.main.bounds
        let yScale = screenSize.height/heightiPhoneSE
        scrollView.setContentOffset(CGPoint(x: 0, y: textField.frame.minY - 250*yScale), animated: true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        scrollView.setContentOffset(CGPoint(x: 0, y: scrollView.contentSize.height - self.view.frame.height), animated: true)
    }
    
}
