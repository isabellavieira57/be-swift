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
        self.backgroundColor = UIColor(red:0.96, green:0.96, blue:0.96, alpha:1.0)

        setTopBar()
        setTextFields()
        setRegisterButton()
    }
    
    func setTextFields()
    {
        let xScale = screenSize.width/widhtiPhoneSE
        let yScale = screenSize.height/heightiPhoneSE
        
        var textFieldFrame = CGRect(x: 24.5*xScale, y: 98*yScale, width: 272, height: 39)
        let textFieldFont = "SanFranciscoText-Medium"
        let textFieldFontSize: CGFloat = 16
        
        nameText = UITextField(frame: textFieldFrame, font: textFieldFont, fontSize: textFieldFontSize)
        nameText.placeholder = "  Name"
        nameText.borderStyle = .line
        nameText.layer.cornerRadius = 5
        
        emailText = UITextField(frame: textFieldFrame, font: textFieldFont, fontSize: textFieldFontSize)
        emailText.frame.origin.y = nameText.frame.origin.y + nameText.frame.height + 15*yScale
        emailText.placeholder = "  E-mail"
        emailText.borderStyle = .line
        emailText.layer.cornerRadius = 5
        
        passwordText = UITextField(frame: textFieldFrame, font: textFieldFont, fontSize: textFieldFontSize)
        passwordText.frame.origin.y = emailText.frame.origin.y + emailText.frame.height + 15*yScale
        passwordText.placeholder = "  Password"
        passwordText.borderStyle = .line
        passwordText.layer.cornerRadius = 5
        
        passwordConfirmationText = UITextField(frame: textFieldFrame, font: textFieldFont, fontSize: textFieldFontSize)
        passwordConfirmationText.frame.origin.y = passwordText.frame.origin.y + passwordText.frame.height + 15*yScale
        passwordConfirmationText.placeholder = "  Confirm password"
        passwordConfirmationText.borderStyle = .line
        passwordConfirmationText.layer.cornerRadius = 5
        
        countryText = UITextField(frame: textFieldFrame, font: textFieldFont, fontSize: textFieldFontSize)
        countryText.frame.origin.y = passwordConfirmationText.frame.origin.y + passwordConfirmationText.frame.height + 15*yScale
        countryText.placeholder = "  Country"
        countryText.borderStyle = .line
        countryText.layer.cornerRadius = 5
        countryText.inputView = pickerCountry

        
        courseText = UITextField(frame: textFieldFrame, font: textFieldFont, fontSize: textFieldFontSize)
        courseText.frame.origin.y = countryText.frame.origin.y + countryText.frame.height + 15*yScale
        courseText.placeholder = "  Course"
        courseText.borderStyle = .line
        courseText.layer.cornerRadius = 5
        courseText.inputView = pickerCourse
        
        self.addSubview(nameText)
        self.addSubview(emailText)
        self.addSubview(passwordText)
        self.addSubview(passwordConfirmationText)
        self.addSubview(countryText)
        self.addSubview(courseText)
    }
    
    func setRegisterButton()
    {
        let xScale = screenSize.width/widhtiPhoneSE
        let yScale = screenSize.height/heightiPhoneSE
        
        signUpButton = UIButton(image: "signUp", frame: CGRect(x: 16*xScale, y: screenSize.height - 62*yScale, width: 288, height: 46), target: self)
    
        self.addSubview(signUpButton)
    }
    
    func setTopBar()
    {
//        let xScale = screenSize.width/widhtiPhoneSE
//        let yScale = screenSize.height/heightiPhoneSE
        
        let rectangle = CAShapeLayer()
        rectangle.path = UIBezierPath(rect: UIScreen.changeScale(vector: CGRect(x: 0, y: 0, width: 320, height: 64))).cgPath
        rectangle.fillColor = UIColor(red:0.31, green:0.49, blue:0.95, alpha:1.0).cgColor
        
        let title = UILabel(text: "Sign up", font: "SanFranciscoText-Semibold", fontSize: 17, aligment: .center, textColor: UIColor.white, frame: CGRect(x: 0, y: 31, width: 320, height: 20))
        
        let backButton = UIButton(image: "backButton", frame: CGRect(x: 12, y: 27, width: 14.29, height: 24), target: self)
        
        self.layer.addSublayer(rectangle)
        self.addSubview(title)
        self.addSubview(backButton)
    }


    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}

