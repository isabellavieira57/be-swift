//
//  LogInViewController.swift
//  be-swift
//
//  Created by Ana Müller on 11/19/17.
//  Copyright © 2017 Isabella Vieira. All rights reserved.
//

import Foundation
import UIKit

class LogInViewController: UIViewController
{
    var emailText: UITextField!
    var passwordText: UITextField!
    var logInButton: UIButton!
    var backButton: UIButton!
    
    let widhtiPhoneSE: CGFloat = 320
    let heightiPhoneSE: CGFloat = 568
    let screenSize = UIScreen.main.bounds

//    override init(frame: CGRect) {
//        super.init(frame: frame)
//
//        self.backgroundColor = UIColor(red:0.96, green:0.96, blue:0.96, alpha:1.0)
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        setTopBar()
        setTextFields()
        setLogInButton()
        
        self.backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        self.logInButton.addTarget(self, action: #selector(logIn), for: .touchUpInside)
    }
    
    @objc func logIn()
    {
        if emailText.text == "" || passwordText.text == ""
        {
            let alert = UIAlertController(title: "Ops!", message: "Please type your e-mail and your password", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
            //Firebase login
        }
    }
    
    @objc func goBack()
    {
        self.dismiss(animated: false, completion: nil)
    }
    
    func setTextFields()
    {
        let xScale = screenSize.width/widhtiPhoneSE
        let yScale = screenSize.height/heightiPhoneSE
        let textFont = "SanFranciscoText-Medium"
        let textSize: CGFloat = 16
        
        emailText = UITextField(frame: CGRect(x: 24*xScale, y: 98*yScale, width: 272*xScale, height: 39*yScale), font: textFont, fontSize: textSize)
        emailText.placeholder = "  E-mail"
        emailText.borderStyle = .none
        emailText.layer.cornerRadius = 5
        
        passwordText = UITextField(frame: emailText.frame, font: textFont, fontSize: textSize)
        passwordText.frame.origin.y = emailText.frame.origin.y + emailText.frame.height + 15*yScale
        passwordText.placeholder = "  Password"
        passwordText.borderStyle = .none
        passwordText.layer.cornerRadius = 5
        
        self.view.addSubview(emailText)
        self.view.addSubview(passwordText)
    }
    
    func setLogInButton()
    {
        let xScale = screenSize.width/widhtiPhoneSE
        let yScale = screenSize.height/heightiPhoneSE
        
        logInButton = UIButton(image: "logIn", frame: CGRect(x: 16*xScale, y: screenSize.height - 62*yScale, width: 288, height: 46), target: self)
        
        self.view.addSubview(logInButton)
    }
    
    func setTopBar()
    {
        //        let xScale = screenSize.width/widhtiPhoneSE
        //        let yScale = screenSize.height/heightiPhoneSE
        
        let rectangle = CAShapeLayer()
        rectangle.path = UIBezierPath(rect: UIScreen.changeScale(vector: CGRect(x: 0, y: 0, width: 320, height: 64))).cgPath
        rectangle.fillColor = UIColor(red:0.31, green:0.49, blue:0.95, alpha:1.0).cgColor
        
        let title = UILabel(text: "Log in", font: "SanFranciscoText-Semibold", fontSize: 17, aligment: .center, textColor: UIColor.white, frame: CGRect(x: 0, y: 31, width: 320, height: 20))
        
        self.backButton = UIButton(image: "backButton", frame: CGRect(x: 12, y: 27, width: 14.29, height: 24), target: self)
        
        self.view.layer.addSublayer(rectangle)
        self.view.addSubview(title)
        self.view.addSubview(backButton)
    }

}

