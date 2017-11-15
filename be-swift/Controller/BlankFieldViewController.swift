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
    var textFieldInput: String!
    let progressView = UIProgressView(progressViewStyle: .bar)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        blankField = BlankFieldView(progressView: progressView, titleText: self.challenge.tags[0] as! String, dismissButtonAction: #selector(BlankFieldViewController.dismissButton(_:)), helpButtonAction: #selector(BlankFieldViewController.helpButton(_:)), questionText: self.challenge.question, exampleCodeText: self.challenge.exampleCode, checkButtonAction:#selector(BlankFieldViewController.checkButton(_:)), currentView: self)
        
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        scrollView.contentSize = CGSize(width: self.view.frame.size.width, height: blankField.frame.height)
        self.view.addSubview(scrollView)
        scrollView.addSubview(blankField)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    override func viewDidAppear(_ animated: Bool){
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: TimeInterval(self.challenge.estimatedTime), animations: { () -> Void in
            self.progressView.setProgress(0.0, animated: true)
        })
    }
    
    @objc func dismissButton(_ sender: Any){
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func helpButton(_ sender: Any){
        let webView = WebDocumentationViewController()
        webView.url = URL(string: self.challenge.resource_link)!
        present(webView, animated: false, completion: nil)
    }
    
    @objc func checkButton(_ sender: Any){
        if textFieldInput == nil{
            let alert = UIAlertController(title: "Ops!", message: "complete the blank field", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else{
            if textFieldInput == self.challenge.correctAnswer[0] as! String {
                print("CORRECT ANSWER")
            }else{
                print("WRONG ANSWER")
                
            }
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
        if textField.frame.minY + textField.frame.height > self.view.frame.height/2{
            scrollView.setContentOffset(CGPoint(x: 0, y: textField.frame.minY - 250*yScale), animated: true)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        scrollView.setContentOffset(CGPoint(x: 0, y: scrollView.contentSize.height - self.view.frame.height), animated: true)
        if !(textField.text?.isEmpty)!{
            textFieldInput = textField.text
        }
    }
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
    
}

