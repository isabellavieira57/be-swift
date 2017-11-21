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
    
    let widhtiPhoneSE: CGFloat = 320
    let heightiPhoneSE: CGFloat = 568
    let screenSize = UIScreen.main.bounds
    
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
        let xScale = screenSize.width/widhtiPhoneSE
        let yScale = screenSize.height/heightiPhoneSE
        let textFont = "SanFranciscoText-Medium"
        let textSize: CGFloat = 16
        
        emailText = UITextField(frame: CGRect(x: 24*xScale, y: 98*yScale, width: 272*xScale, height: 39*yScale), font: textFont, fontSize: textSize)
        emailText.placeholder = "E-mail"
        emailText.borderStyle = .none
        emailText.layer.cornerRadius = 5
        emailText.keyboardType = .emailAddress
        emailText.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
        
        passwordText = UITextField(frame: emailText.frame, font: textFont, fontSize: textSize)
        passwordText.frame.origin.y = emailText.frame.origin.y + emailText.frame.height + 15*yScale
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
        let xScale = screenSize.width/widhtiPhoneSE
        let yScale = screenSize.height/heightiPhoneSE
        
        logInButton = UIButton(image: "logIn", frame: CGRect(x: 16*xScale, y: screenSize.height - 62*yScale, width: 288, height: 46), target: self)
        logInButton.addTarget(self, action: logInAction, for: .touchUpInside)
        
        self.addSubview(logInButton)
    }
    
    func setTopBar(goBackAction: Selector)
    {
        //        let xScale = screenSize.width/widhtiPhoneSE
        //        let yScale = screenSize.height/heightiPhoneSE
        
        let rectangle = CAShapeLayer()
        rectangle.path = UIBezierPath(rect: UIScreen.changeScale(vector: CGRect(x: 0, y: 0, width: 320, height: 64))).cgPath
        rectangle.fillColor = UIColor(red:0.31, green:0.49, blue:0.95, alpha:1.0).cgColor
        
        let title = UILabel(text: "Log in", font: "SanFranciscoText-Semibold", fontSize: 18, aligment: .center, textColor: UIColor.white, frame: CGRect(x: 0, y: 31, width: 320, height: 20))
        
        backButton = UIButton(image: "backButton", frame: CGRect(x: 12, y: 27, width: 14.29, height: 24), target: self)
        backButton.addTarget(self, action: goBackAction, for: .touchUpInside)
        
        self.layer.addSublayer(rectangle)
        self.addSubview(title)
        self.addSubview(backButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
