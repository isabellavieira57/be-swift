//
//  LoginView.swift
//  be-swift
//
//  Created by Isabella Vieira on 08/10/17.
//  Copyright © 2017 Isabella Vieira. All rights reserved.
//
import Foundation
import UIKit

class LoginView: UIView
{
    var emailText: UITextField!
    var passwordText: UITextField!
    var logInButton: UIButton!
    var backButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
    }
    
    convenience init (goBack: Selector, logIn: Selector)
    {
        self.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        
        setTopBar(goBackAction: goBack)
        setTextFields()
        setLogInButton(logInAction: logIn)
    }
    
    func setTextFields()
    {
        let textFont = "SanFranciscoText-Medium"
        let textSize: CGFloat = 16
        
        emailText = UITextField(frame: CGRect(x: 24, y: 98, width: 272, height: 39), font: textFont, fontSize: textSize)
        emailText.placeholder = "E-mail"
        emailText.borderStyle = .none
        emailText.layer.cornerRadius = 5
        emailText.keyboardType = .emailAddress
        emailText.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
        emailText.autocapitalizationType = .none
        
        passwordText = UITextField(frame: CGRect(x: 24, y: 152, width: 272, height: 39), font: textFont, fontSize: textSize)
        passwordText.placeholder = "Password"
        passwordText.borderStyle = .none
        passwordText.layer.cornerRadius = 5
        passwordText.isSecureTextEntry = true
        passwordText.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
        
        self.addSubview(emailText)
        self.addSubview(passwordText)
    }
    
    func setLogInButton(logInAction: Selector)
    {
        logInButton = UIButton(image: "logIn", frame: CGRect(x: 16, y: 506, width: 288, height: 46), target: self)
        logInButton.addTarget(target, action: logInAction, for: .touchUpInside)
        
        self.addSubview(logInButton)
    }
    
    func setTopBar(goBackAction: Selector)
    {
        let rectangle = CAShapeLayer()
        rectangle.path = UIBezierPath(rect: UIScreen.changeScale(vector: CGRect(x: 0, y: 0, width: 320, height: 64))).cgPath
        rectangle.fillColor = UIColor(red:0.31, green:0.49, blue:0.95, alpha:1.0).cgColor
        
        let title = UILabel(text: "Log in", font: "SanFranciscoText-Semibold", fontSize: 18, aligment: .center, textColor: UIColor.white, frame: CGRect(x: 0, y: 31, width: 320, height: 20))
        
        backButton = UIButton(image: "backButton", frame: CGRect(x: 12, y: 27, width: 14.29, height: 24), target: self)
        backButton.addTarget(target, action: goBackAction, for: .touchUpInside)
        
        self.layer.addSublayer(rectangle)
        self.addSubview(title)
        self.addSubview(backButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
