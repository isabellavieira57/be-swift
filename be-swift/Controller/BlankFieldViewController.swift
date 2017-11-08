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
    
    var resource_link: String!
    var question: String!
    var exampleCode: String!
    var estimatedTime: Int!
    //var correctAnswer: String!
    var correctAnswer = "2"
    var feedbackAnswer: String!
    var tags: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        blankField = BlankFieldView(titleText: self.tags, dismissButtonAction: #selector(BlankFieldViewController.dismissButton(_:)), helpButtonAction: #selector(BlankFieldViewController.helpButton(_:)), questionText: self.question, exampleCodeText: self.exampleCode, checkButtonAction:#selector(BlankFieldViewController.checkButton(_:)), currentView: self)
        
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
        webView.url = URL(string: resource_link)!
        present(webView, animated: false, completion: nil)
    }
    
    @objc func checkButton(_ sender: Any){
        if blankField.blankField.text == correctAnswer{
            print("CERTO")
        } else {
            print("ERADO")
        }
        
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
