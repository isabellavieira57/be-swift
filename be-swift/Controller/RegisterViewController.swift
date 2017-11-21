//
//  RegisterViewController.swift
//  be-swift
//
//  Created by Ana Müller on 11/19/17.
//  Copyright © 2017 Isabella Vieira. All rights reserved.
//

import Foundation
import UIKit

class RegisterViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate
{
    var registerView: RegisterView!

    var countryList: Array<String>!
    var courseList: Array<String>!

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        registerView = RegisterView(goBack: #selector(goBack), signUp: #selector(checkInfo))

        self.registerView.pickerCountry.delegate = self
        self.registerView.pickerCourse.delegate = self
        self.registerView.pickerCountry.dataSource = self
        self.registerView.pickerCourse.dataSource = self
        
        countryList = ["Brazil", "United States of America", "Canada"]
        courseList = ["Business Administration","Computer Science", "Design", "Engineering", "Law"]
        
        self.view.addSubview(registerView)
        
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(tap)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        var numberOfRows = 0
        
        if pickerView == self.registerView.pickerCountry
        {
            numberOfRows = self.countryList.count
        }
        else if pickerView == self.registerView.pickerCourse
        {
            numberOfRows = self.courseList.count
        }
        return numberOfRows
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        var listItem = ""
        
        if pickerView == self.registerView.pickerCountry
        {
            listItem = self.countryList[row]
        }
        else if pickerView == self.registerView.pickerCourse
        {
            listItem = self.courseList[row]
        }
        return listItem
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        if pickerView == self.registerView.pickerCountry
        {
            self.registerView.countryText.text = self.countryList[row]
            self.registerView.countryText.endEditing(true)
        }
        else if pickerView == self.registerView.pickerCourse
        {
            self.registerView.courseText.text = self.courseList[row]
            self.registerView.courseText.endEditing(true)
        }
    }
  
    @objc func checkInfo()
    {
        
        let nameTxt = self.registerView.nameText.text
        let emailTxt = self.registerView.emailText.text
        let passwordTxt = self.registerView.passwordText.text
        let passwordCheckTxt = self.registerView.passwordConfirmationText.text
        let countryTxt = self.registerView.countryText.text
        let courseTxt = self.registerView.courseText.text
        
//        self.registerView.dismissKeyboard()
        
        if nameTxt == "" || emailTxt == "" || passwordTxt == "" || passwordCheckTxt == "" || countryTxt == "" || courseTxt == ""
        {
            showAlert(title: "Ops!", message: "Please complete all text fields.")
            return
            
        } else if (passwordTxt?.count)! < 6
        {
            showAlert(title: "Ops!", message: "Your password should be at least 6 characters long.")
            return
            
        } else if passwordTxt != passwordCheckTxt
        {
            showAlert(title: "Ops!", message: "The passwords you typed don't match.")
            return
            
        } else if isValidEmail(testStr: emailTxt!) == false
        {
            showAlert(title: "Ops!", message: "Please type a valid e-mail address.")
            return
            
        } else
        {
            //Firebase - create user
            showAlert(title: "Welcome!", message: "Your account was successfully created!")
            openMainController()
        }
    }
    
    func isValidEmail(testStr:String) -> Bool
    {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    func openMainController()
    {
        let controller = ViewController()
        present(controller, animated: true, completion: nil)
        
        //        //change root view controller
        //        let delegate = UIApplication.shared.delegate as! AppDelegate
        //        let window = delegate.window
        //        window?.rootViewController = controller
    }
    
    func showAlert(title: String, message: String)
    {
        let alert = UIAlertController(title: "Ops!", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func goBack(_ sender: Any)
    {
        self.dismiss(animated: false, completion: nil)
    }
    
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
}



