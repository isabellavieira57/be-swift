//
//  RegisterViewController.swift
//  be-swift
//
//  Created by Isabella Vieira on 22/11/17.
//  Copyright © 2017 Isabella Vieira. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class RegisterViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UserHandler, UITextFieldDelegate  {

    var topView: TopViewRegister!
    var scrollView: UIScrollView!
    
    var continentList: Array<String>!
    var countryListAfrica: Array<String>!
    var countryListAsia: Array<String>!
    var countryListEurope: Array<String>!
    var countryListNorthAm: Array<String>!
    var countryListSouthAm: Array<String>!
    var countryListOceania: Array<String>!
    var courseList: Array<String>!
    var selectedContinent: String!
    
    var indicator = UIActivityIndicatorView()
    var registerView: RegisterView!
    var user = User()
    var userDAO = UserDAO()
    var success: Bool?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        print ("CONTROLLER - selector")
        
        topView = TopViewRegister(goBackAction: #selector(RegisterViewController.goBack(_:)))
        self.view.addSubview(topView)
        
        registerView = RegisterView(signUp: #selector(checkInfo))
        
        let yPosition = topView.yPosition
        
        scrollView = UIScrollView(frame: CGRect(x: 0, y: yPosition!, width: self.view.frame.size.width, height: self.view.frame.size.height))
        scrollView.contentSize = CGSize(width: self.view.frame.size.width, height: registerView.frame.height)
        
        //Delegate and data source pickerViews
        self.registerView.pickerContinent.dataSource = self
        self.registerView.pickerCountry.dataSource = self
        self.registerView.pickerCourse.dataSource = self
        self.registerView.pickerContinent.delegate = self
        self.registerView.pickerCountry.delegate = self
        self.registerView.pickerCourse.delegate = self
        //Delegate textFields
        self.registerView.nameText.delegate = self
        self.registerView.emailText.delegate = self
        self.registerView.passwordText.delegate = self
        self.registerView.passwordConfirmationText.delegate = self
        self.registerView.continentText.delegate = self
        self.registerView.countryText.delegate = self
        self.registerView.courseText.delegate = self
        
        setArrays()
        
        self.view.addSubview(topView)
        self.view.addSubview(scrollView)
        scrollView.addSubview(registerView)
//        self.view.addSubview(registerView)
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(tap)
    }
    
    func activityIndicator() {
        indicator = UIActivityIndicatorView()
        indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        indicator.center = self.view.center
        DispatchQueue.main.async {
            self.view.addSubview(self.indicator)
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var numberOfRows = 0
        
        if pickerView == self.registerView.pickerContinent {
            numberOfRows = self.continentList.count
        } else if pickerView == self.registerView.pickerCountry {
            switch selectedContinent {
            case "Africa":
                numberOfRows = self.countryListAfrica.count
            case "Asia":
                numberOfRows = self.countryListAsia.count
            case "Europe":
                numberOfRows = self.countryListEurope.count
            case "North America":
                numberOfRows = self.countryListNorthAm.count
            case "South America":
                numberOfRows = self.countryListSouthAm.count
            case "Oceania":
                numberOfRows = self.countryListOceania.count
            default:
                numberOfRows = 1
            }
        } else if pickerView == self.registerView.pickerCourse {
            numberOfRows = self.courseList.count
        }
        return numberOfRows
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        var listItem = ""
        
        if pickerView == self.registerView.pickerContinent {
            listItem = self.continentList[row]
        } else if pickerView == self.registerView.pickerCountry {
            switch selectedContinent {
            case "Africa":
                listItem = self.countryListAfrica[row]
            case "Asia":
                listItem = self.countryListAsia[row]
            case "Europe":
                listItem = self.countryListEurope[row]
            case "North America":
                listItem = self.countryListNorthAm[row]
            case "South America":
                listItem = self.countryListSouthAm[row]
            case "Oceania":
                listItem = self.countryListOceania[row]
            default:
                listItem = ""
            }
        } else if pickerView == self.registerView.pickerCourse {
            listItem = self.courseList[row]
        }
        return listItem
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == self.registerView.pickerContinent {
            self.registerView.continentText.text = self.continentList[row]
            self.registerView.continentText.endEditing(true)
            self.selectedContinent = self.continentList[row]
            
        } else if pickerView == self.registerView.pickerCountry {
            switch selectedContinent {
            case "Africa":
                self.registerView.countryText.text = self.countryListAfrica[row]
            case "Asia":
                self.registerView.countryText.text = self.countryListAsia[row]
            case "Europe":
                self.registerView.countryText.text = self.countryListEurope[row]
            case "North America":
                self.registerView.countryText.text = self.countryListNorthAm[row]
            case "South America":
                self.registerView.countryText.text = self.countryListSouthAm[row]
            case "Oceania":
                self.registerView.countryText.text = self.countryListOceania[row]
            default:
                self.registerView.countryText.text = ""
            }
            self.registerView.countryText.endEditing(true)
            
        } else if pickerView == self.registerView.pickerCourse {
            self.registerView.courseText.text = self.courseList[row]
            self.registerView.courseText.endEditing(true)
        }
    }
    
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    // Botao de confirmar cadastro
    @objc func checkInfo() {
        print ("ENTROU CHECK INFO")
        let nameTxt = self.registerView.nameText.text
        let emailTxt = self.registerView.emailText.text?.lowercased()
        let passwordTxt = self.registerView.passwordText.text
        let passwordCheckTxt = self.registerView.passwordConfirmationText.text
        let countryTxt = self.registerView.countryText.text
        let courseTxt = self.registerView.courseText.text
        
        print ("CONTROLLER - CHECKING DATA")
        //Verificações para cadastro
        if nameTxt == "" || emailTxt == "" || passwordTxt == "" || passwordCheckTxt == "" {
            showAlert(title: "Ops!", message: "Please inform your e-mail and choose a password.")
            return
        } else if (passwordTxt?.count)! < 6 {
            showAlert(title: "Ops!", message: "Your password should be at least 6 characters long.")
            return
        } else if passwordTxt != passwordCheckTxt {
            showAlert(title: "Ops!", message: "The passwords you typed don't match.")
            return
        } else if isValidEmail(testStr: emailTxt!) == false {
            showAlert(title: "Ops!", message: "Please type a valid e-mail address.")
            return
        } else {
            //Firebase - create user
            print ("CONTROLLER - REGISTER")
            userDAO.registerUser(handler: self, email: emailTxt!, password: passwordTxt!)
            
            // salva no banco os dados do formulario
            print ("CONTROLLER - SAVE DATABASE")
            userDAO.saveRegistration(name: nameTxt!, email: emailTxt!, password: passwordTxt!, country: countryTxt!, major: courseTxt!)
        }
    }
    
    func loginUser(success: Bool) {
        self.success = success
        indicator.stopAnimating()
        indicator.hidesWhenStopped = true
        
        if (self.success == true) {
            print("You have successfully registered")
            showAlert(title: "Welcome!", message: "Your account was successfully created!")
            
            //Define novo rootViewController e redireciona ao controller dos challenges
            let viewController = ViewController()
            let delegate = UIApplication.shared.delegate as! AppDelegate
            let window = delegate.window
            window?.rootViewController = viewController
            self.present(viewController, animated: true, completion: nil)
            
        } else if (success == false) {
            print("registro falhooou")
            let alert = UIAlertController(title: "Registration Failed!", message: "The email address is already in use by another account", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(defaultAction)
            self.present(alert, animated: true, completion: nil)
        }
    }

    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: title, style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField){

        let heightiPhoneSE: CGFloat = 568
        let screenSize = UIScreen.main.bounds
        let yScale = screenSize.height/heightiPhoneSE

        if textField.frame.origin.y + textField.frame.height + 20*yScale > 318*yScale {
            self.registerView.frame.origin.y -= (self.registerView.pickerCountry.frame.height - self.registerView.signUpButton.frame.height - 16*yScale)
        }
    }

    func textFieldDidEndEditing(_ textField: UITextField){
        self.registerView.frame.origin.y = 0
    }

    @objc func goBack(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }

    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    func setArrays()
    {
        continentList = ["Africa","Asia","Europe","North America","South America","Oceania"]
        
        countryListAfrica = ["Algeria", "Angola", "Benin", "Botswana", "Burkina", "Burundi", "Cameroon", "Cape Verde", "Central African Republic", "Chad", "Comoros", "Congo", "Democratic Republic of Congo", "Djibouti", "Egypt", "Equatorial Guinea", "Eritrea", "Ethiopia", "Gabon", "Gambia", "Ghana", "Guinea", "Guinea-Bissau", "Ivory Coast", "Kenya", "Lesotho", "Liberia", "Libya", "Madagascar", "Malawi", "Mali", "Mauritania", "Mauritius", "Morocco", "Mozambique", "Namibia", "Niger", "Nigeria", "Rwanda", "Sao Tome and Principe", "Senegal", "Seychelles", "Sierra Leone", "Somalia", "South Africa", "South Sudan", "Sudan", "Swaziland", "Tanzania", "Togo", "Tunisia", "Uganda", "Zambia", "Zimbabwe"]
        countryListAsia = ["Afghanistan", "Bahrain", "Bangladesh", "Bhutan", "Brunei", "Cambodia", "China", "East Timor", "India", "Indonesia", "Iran", "Iraq", "Israel", "Japan", "Jordan", "Kazakhstan", "North Korea", "South Korea", "Kuwait", "Kyrgyzstan", "Laos", "Lebanon", "Malaysia", "Maldives", "Mongolia", "Myanmar (Burma)", "Nepal", "Oman", "Pakistan", "Philippines", "Qatar", "Russian Federation", "Saudi Arabia", "Singapore", "Sri Lanka", "Syria", "Tajikistan", "Thailand", "Turkey", "Turkmenistan", "United Arab Emirates", "Uzbekistan", "Vietnam", "Yemen"]
        countryListEurope = ["Albania", "Andorra", "Armenia", "Austria", "Azerbaijan", "Belarus", "Belgium", "Bosnia and Herzegovina", "Bulgaria", "Croatia", "Cyprus", "Czech Republic", "Denmark", "Estonia", "Finland", "France", "Georgia", "Germany", "Greece", "Hungary", "Iceland", "Ireland", "Italy", "Latvia", "Liechtenstein", "Lithuania", "Luxembourg", "Macedonia", "Malta", "Moldova", "Monaco", "Montenegro", "Netherlands", "Norway", "Poland", "Portugal", "Romania", "San Marino", "Serbia", "Slovakia", "Slovenia", "Spain", "Sweden", "Switzerland", "Ukraine", "United Kingdom", "Vatican City"]
        countryListNorthAm = ["United States","Antigua and Barbuda", "Bahamas", "Barbados", "Belize", "Canada", "Costa Rica", "Cuba", "Dominica", "Dominican Republic", "El Salvador", "Grenada", "Guatemala", "Haiti", "Honduras", "Jamaica", "Mexico", "Nicaragua", "Panama", "Saint Kitts and Nevis", "Saint Lucia", "Saint Vincent and the Grenadines", "Trinidad and Tobago"]
        countryListSouthAm = ["Argentina", "Bolivia", "Brazil", "Chile", "Colombia", "Ecuador", "Guyana", "Paraguay", "Peru", "Suriname", "Uruguay", "Venezuela"]
        countryListOceania = ["Australia", "Fiji", "Kiribati", "Marshall Islands", "Micronesia", "Nauru", "New Zealand", "Palau", "Papua New Guinea", "Samoa", "Solomon Islands", "Tonga", "Tuvalu", "Vanuatu"]
        
        courseList = ["Anthropology, Sociology or Philosophy", "Arts-related", "Business-related", "Communication studies", "Computer science/ IT/Technology", "Criminology", "Design", "Economics", "Education", "Engineering", "Geography", "Health-related", "History", "International relations", "Law", "Linguistics", "Math-related", "Natural Sciences", "Political science", "Psychology", "Theology"]
    }
}
