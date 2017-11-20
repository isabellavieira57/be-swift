////
////  RegisterViewController.swift
////  be-swift
////
////  Created by Ana Müller on 11/19/17.
////  Copyright © 2017 Isabella Vieira. All rights reserved.
////

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
        
        registerView = RegisterView()

        self.registerView.pickerCountry.delegate = self
        self.registerView.pickerCourse.delegate = self
        self.registerView.pickerCountry.dataSource = self
        self.registerView.pickerCourse.dataSource = self
        
        countryList = ["Brazil", "United States of America", "Canada"]
        courseList = ["Business Administration","Computer Science", "Design", "Engineering", "Law"]
        
        self.view.addSubview(registerView)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
//        if pickerView == self.registerView.pickerCountry
//        {
            return self.countryList.count
//        }
//        else if pickerView == self.registerView.pickerCourse
//        {
//            return self.courseList.count
//        }
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String!
    {
//        if pickerView == self.registerView.pickerCountry
//        {
            return self.countryList[row]
//        }
//        else if pickerView == self.registerView.pickerCourse
//        {
//            return self.courseList[row]
//        }
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
//        if pickerView == self.registerView.pickerCountry
//        {
            self.registerView.countryText.text = self.countryList[row]
            self.registerView.countryText.endEditing(true)
//        }
//        else if pickerView == self.registerView.pickerCourse
//        {
//            self.registerView.courseText.text = self.courseList[row]
//            self.registerView.courseText.endEditing(true)
//        }
    }
}



