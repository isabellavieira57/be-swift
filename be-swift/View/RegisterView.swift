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
    
    var nameLabel: UILabel!
    var emailLabel: UILabel!
    var passwordLabel: UILabel!
    var passwordConfirmLabel: UILabel!
    var countryLabel: UILabel!
    var courseLabel: UILabel!
    
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
    }
    
    func setTextFields()
    {
        let heightiPhoneSE: CGFloat = 568
        let screenSize = UIScreen.main.bounds
        let yScale = screenSize.height/heightiPhoneSE
        
        let textFieldFrame = CGRect(x: 24, y: 75, width: 272, height: 39)
        let font = "SanFranciscoText-Medium"
        let textFontSize: CGFloat = 16
        let labelFontSize: CGFloat = 14
        let labelAlignment = NSTextAlignment.left
//        let labelTextColor = UIColor(red:0.73, green:0.73, blue:0.73, alpha:1.0)
        let labelTextColor = UIColor(red:0.6, green:0.6, blue:0.6, alpha:1.0)
        let labelFrame  = CGRect(x: textFieldFrame.origin.x, y: textFieldFrame.origin.y, width: 272, height: 20)
        let marginFromPreviousField: CGFloat = 8*yScale
        let marginFromDescription: CGFloat = 2*yScale
        
        nameLabel = UILabel(text: "Name", font: font, fontSize: labelFontSize, aligment: labelAlignment, textColor: labelTextColor, frame: labelFrame)
        
        nameText = UITextField(frame: textFieldFrame, font: font, fontSize: textFontSize)
        nameText.frame.origin.y = nameLabel.frame.origin.y + nameLabel.frame.height + marginFromDescription
//        nameText.placeholder = "Name"
        nameText.borderStyle = .none
        nameText.layer.cornerRadius = 5
        nameText.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
        
        emailLabel = UILabel(text: "E-mail", font: font, fontSize: labelFontSize, aligment: labelAlignment, textColor: labelTextColor, frame: labelFrame)
        emailLabel.frame.origin.y = nameText.frame.origin.y + nameText.frame.height + marginFromPreviousField
        
        emailText = UITextField(frame: textFieldFrame, font: font, fontSize: textFontSize)
        emailText.frame.origin.y = emailLabel.frame.origin.y + emailLabel.frame.height + marginFromDescription
//        emailText.placeholder = "E-mail"
        emailText.borderStyle = .none
        emailText.layer.cornerRadius = 5
        emailText.autocapitalizationType = .none
        emailText.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
        emailText.keyboardType = .emailAddress
        
        passwordLabel = UILabel(text: "Password", font: font, fontSize: labelFontSize, aligment: labelAlignment, textColor: labelTextColor, frame: labelFrame)
        passwordLabel.frame.origin.y = emailText.frame.origin.y + emailText.frame.height + marginFromPreviousField
        
        passwordText = UITextField(frame: textFieldFrame, font: font, fontSize: textFontSize)
        passwordText.frame.origin.y = passwordLabel.frame.origin.y + passwordLabel.frame.height + marginFromDescription
//        passwordText.placeholder = "Password"
        passwordText.borderStyle = .none
        passwordText.layer.cornerRadius = 5
        passwordText.autocapitalizationType = .none
        passwordText.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
        passwordText.isSecureTextEntry = true
        
        passwordConfirmLabel = UILabel(text: "Confirm your password", font: font, fontSize: labelFontSize, aligment: labelAlignment, textColor: labelTextColor, frame: labelFrame)
        passwordConfirmLabel.frame.origin.y = passwordText.frame.origin.y + passwordText.frame.height + marginFromPreviousField
        
        passwordConfirmationText = UITextField(frame: textFieldFrame, font: font, fontSize: textFontSize)
        passwordConfirmationText.frame.origin.y = passwordConfirmLabel.frame.origin.y + passwordConfirmLabel.frame.height + marginFromDescription
//        passwordConfirmationText.placeholder = "Confirm password"
        passwordConfirmationText.borderStyle = .none
        passwordConfirmationText.layer.cornerRadius = 5
        passwordConfirmationText.autocapitalizationType = .none
        passwordConfirmationText.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
        passwordConfirmationText.isSecureTextEntry = true
        
        countryLabel = UILabel(text: "Country", font: font, fontSize: labelFontSize, aligment: labelAlignment, textColor: labelTextColor, frame: labelFrame)
        countryLabel.frame.origin.y = passwordConfirmationText.frame.origin.y + passwordConfirmationText.frame.height + marginFromPreviousField
        
        countryText = UITextField(frame: textFieldFrame, font: font, fontSize: textFontSize)
        countryText.frame.origin.y = countryLabel.frame.origin.y + countryLabel.frame.height + marginFromDescription
//        countryText.placeholder = "Country"
        countryText.borderStyle = .none
        countryText.layer.cornerRadius = 5
        countryText.inputView = pickerCountry
        countryText.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
        
        courseLabel = UILabel(text: "Course", font: font, fontSize: labelFontSize, aligment: labelAlignment, textColor: labelTextColor, frame: labelFrame)
        courseLabel.frame.origin.y = countryText.frame.origin.y + countryText.frame.height + marginFromPreviousField
        
        courseText = UITextField(frame: textFieldFrame, font: font, fontSize: textFontSize)
        courseText.frame.origin.y = courseLabel.frame.origin.y + courseLabel.frame.height + marginFromDescription
//        courseText.placeholder = "Course"
        courseText.borderStyle = .none
        courseText.layer.cornerRadius = 5
        courseText.inputView = pickerCourse
        courseText.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
        
        self.addSubview(nameLabel)
        self.addSubview(nameText)
        self.addSubview(emailLabel)
        self.addSubview(emailText)
        self.addSubview(passwordLabel)
        self.addSubview(passwordText)
        self.addSubview(passwordConfirmLabel)
        self.addSubview(passwordConfirmationText)
        self.addSubview(countryLabel)
        self.addSubview(countryText)
        self.addSubview(courseLabel)
        self.addSubview(courseText)
    }
    
    func setRegisterButton(signUpAction: Selector)
    {
        signUpButton = UIButton(image: "signUp", frame: CGRect(x: 16, y: 506, width: 288, height: 46), target: self)
        signUpButton.addTarget(target, action: signUpAction, for: .touchUpInside)
        
        self.addSubview(signUpButton)
    }
    
    func setTopBar(goBackAction: Selector)
    {
        let rectangle = CAShapeLayer()
        rectangle.path = UIBezierPath(rect: UIScreen.changeScale(vector: CGRect(x: 0, y: 0, width: 320, height: 64))).cgPath
        rectangle.fillColor = UIColor(red:0.31, green:0.49, blue:0.95, alpha:1.0).cgColor
        
        let title = UILabel(text: "Sign up", font: "SanFranciscoText-Semibold", fontSize: 18, aligment: .center, textColor: UIColor.white, frame: CGRect(x: 0, y: 31, width: 320, height: 20))
        
        let backButton = UIButton(image: "backButton", frame: CGRect(x: 12, y: 27, width: 14.29, height: 24), target: self)
        backButton.addTarget(target, action: goBackAction, for: .touchUpInside)
        
        self.layer.addSublayer(rectangle)
        self.addSubview(title)
        self.addSubview(backButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
