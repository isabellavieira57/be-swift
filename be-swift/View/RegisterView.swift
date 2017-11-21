//
//  RegisterView.swift
//  be-swift
//
//  Created by Isabella Vieira on 08/10/17.
//  Copyright © 2017 Isabella Vieira. All rights reserved.
//

import Foundation
import UIKit

class RegisterView: UIView
{
    var nameText: UITextField!
    var emailText: UITextField!
    var passwordText: UITextField!
    var passwordConfirmationText: UITextField!
    var countryText: UITextField!
    var courseText: UITextField!
    var signUpButton: UIButton!

    let widhtiPhoneSE: CGFloat = 320
    let heightiPhoneSE: CGFloat = 568
    let screenSize = UIScreen.main.bounds
    
    let pickerCountry = UIPickerView()
    let pickerCourse = UIPickerView()
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
    }
    
    convenience init (goBack: Selector, signUp: Selector)
    {
        self.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        
        setTopBar(goBackAction: goBack)
        setTextFields()
        setRegisterButton(signUpAction: signUp)
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.addGestureRecognizer(tap)
    }
    
    func setTextFields()
    {
        let xScale = screenSize.width/widhtiPhoneSE
        let yScale = screenSize.height/heightiPhoneSE
        
        var textFieldFrame = CGRect(x: 24*xScale, y: 98*yScale, width: 272, height: 39)
        let textFieldFont = "SanFranciscoText-Medium"
        let textFieldFontSize: CGFloat = 16
        
        nameText = UITextField(frame: textFieldFrame, font: textFieldFont, fontSize: textFieldFontSize)
        nameText.placeholder = "Name"
        nameText.borderStyle = .none
        nameText.layer.cornerRadius = 5
        nameText.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
        
        emailText = UITextField(frame: textFieldFrame, font: textFieldFont, fontSize: textFieldFontSize)
        emailText.frame.origin.y = nameText.frame.origin.y + nameText.frame.height + 15*yScale
        emailText.placeholder = "E-mail"
        emailText.borderStyle = .none
        emailText.layer.cornerRadius = 5
        emailText.autocapitalizationType = .none
        emailText.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
        emailText.keyboardType = .emailAddress
        
        passwordText = UITextField(frame: textFieldFrame, font: textFieldFont, fontSize: textFieldFontSize)
        passwordText.frame.origin.y = emailText.frame.origin.y + emailText.frame.height + 15*yScale
        passwordText.placeholder = "Password"
        passwordText.borderStyle = .none
        passwordText.layer.cornerRadius = 5
        passwordText.autocapitalizationType = .none
        passwordText.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
        passwordText.isSecureTextEntry = true
        
        passwordConfirmationText = UITextField(frame: textFieldFrame, font: textFieldFont, fontSize: textFieldFontSize)
        passwordConfirmationText.frame.origin.y = passwordText.frame.origin.y + passwordText.frame.height + 15*yScale
        passwordConfirmationText.placeholder = "Confirm password"
        passwordConfirmationText.borderStyle = .none
        passwordConfirmationText.layer.cornerRadius = 5
        passwordConfirmationText.autocapitalizationType = .none
        passwordConfirmationText.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
        passwordConfirmationText.isSecureTextEntry = true

        countryText = UITextField(frame: textFieldFrame, font: textFieldFont, fontSize: textFieldFontSize)
        countryText.frame.origin.y = passwordConfirmationText.frame.origin.y + passwordConfirmationText.frame.height + 15*yScale
        countryText.placeholder = "Country"
        countryText.borderStyle = .none
        countryText.layer.cornerRadius = 5
        countryText.inputView = pickerCountry
        countryText.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
        
        courseText = UITextField(frame: textFieldFrame, font: textFieldFont, fontSize: textFieldFontSize)
        courseText.frame.origin.y = countryText.frame.origin.y + countryText.frame.height + 15*yScale
        courseText.placeholder = "Course"
        courseText.borderStyle = .none
        courseText.layer.cornerRadius = 5
        courseText.inputView = pickerCourse
        courseText.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
        
        self.addSubview(nameText)
        self.addSubview(emailText)
        self.addSubview(passwordText)
        self.addSubview(passwordConfirmationText)
        self.addSubview(countryText)
        self.addSubview(courseText)
    }
    
    func setRegisterButton(signUpAction: Selector)
    {
        let xScale = screenSize.width/widhtiPhoneSE
        let yScale = screenSize.height/heightiPhoneSE
        
        signUpButton = UIButton(image: "signUp", frame: CGRect(x: 16*xScale, y: 506*yScale, width: 288, height: 46), target: self)
        signUpButton.addTarget(self, action: signUpAction, for: .touchUpInside)
    
        self.addSubview(signUpButton)
    }
    
    func setTopBar(goBackAction: Selector)
    {
//        let xScale = screenSize.width/widhtiPhoneSE
//        let yScale = screenSize.height/heightiPhoneSE
        
        let rectangle = CAShapeLayer()
        rectangle.path = UIBezierPath(rect: UIScreen.changeScale(vector: CGRect(x: 0, y: 0, width: 320, height: 64))).cgPath
        rectangle.fillColor = UIColor(red:0.31, green:0.49, blue:0.95, alpha:1.0).cgColor
        
        let title = UILabel(text: "Sign up", font: "SanFranciscoText-Semibold", fontSize: 18, aligment: .center, textColor: UIColor.white, frame: CGRect(x: 0, y: 31, width: 320, height: 20))
        
        let backButton = UIButton(image: "backButton", frame: CGRect(x: 12, y: 27, width: 14.29, height: 24), target: self)
        backButton.addTarget(self, action: goBackAction, for: .touchUpInside)
        
        self.layer.addSublayer(rectangle)
        self.addSubview(title)
        self.addSubview(backButton)
    }
    
    @objc func dismissKeyboard() {
        self.endEditing(true)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

