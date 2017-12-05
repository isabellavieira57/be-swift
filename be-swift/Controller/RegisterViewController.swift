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
    
    //Arrays para os picker views
    var continentList: Array<String>!
    var countryListAfrica: Array<String>!
    var countryListAsia: Array<String>!
    var countryListEurope: Array<String>!
    var countryListNorthAm: Array<String>!
    var countryListSouthAm: Array<String>!
    var countryListOceania: Array<String>!
    var courseList: Array<String>!
    
    //Variáveis auxiliares para os picker views funcionarem corretamente
    var selectedContinent: String!
    var selectedText: String!
    var selectedTextField: UITextField!
    
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
        setPickerAccessory()
        
        self.view.addSubview(topView)
        self.view.addSubview(scrollView)
        scrollView.addSubview(registerView)
        
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
            case nil:
                numberOfRows = 1
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
            case "I'd rather not say":
                numberOfRows = 1
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
            case nil:
                listItem = ""
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
                listItem = "I'd rather not say"
            }
        } else if pickerView == self.registerView.pickerCourse {
            listItem = self.courseList[row]
        }
        return listItem
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView == self.registerView.pickerContinent
        {
            self.selectedText = self.continentList[row]
            self.selectedContinent = self.continentList[row]
            
        } else if pickerView == self.registerView.pickerCountry
        {
            switch selectedContinent
            {
            case nil:
                break
            case "Africa":
                self.selectedText = self.countryListAfrica[row]
            case "Asia":
                self.selectedText = self.countryListAsia[row]
            case "Europe":
                self.selectedText = self.countryListEurope[row]
            case "North America":
                self.selectedText = self.countryListNorthAm[row]
            case "South America":
                self.selectedText = self.countryListSouthAm[row]
            case "Oceania":
                self.selectedText = self.countryListOceania[row]
            default:
                self.selectedText = "I'd rather not say"
            }
            
        } else if pickerView == self.registerView.pickerCourse
        {
            self.selectedText = self.courseList[row]
        }
    }
    
    @objc func donePicker()
    {
        //se o usuário ainda não escolheu um continente e tentar escolher o país, retornar lista vazia
        if self.selectedText == nil && self.selectedContinent == nil && self.selectedTextField == self.registerView.countryText
        {
            self.selectedTextField.text = ""
            //se o usuário clicou "Done" sem mexer o picker, retornar primeiro item do array ("I'd rather not say")
        } else if self.selectedText == nil
        {
            self.selectedTextField.text = "I'd rather not say"
        } else
            //retornar item selecionado
        {
            self.selectedTextField.text = self.selectedText
        }
        self.selectedTextField.endEditing(true)
        self.selectedTextField.resignFirstResponder()
        self.selectedText = "I'd rather not say"
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
        if nameTxt == "" || emailTxt == "" || passwordTxt == "" || passwordCheckTxt == "" || countryTxt == "" || courseTxt == "" {
            showAlert(title: "Ops!", message: "Please complete all text fields.")
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
            self.registerView.frame.origin.y -= (self.registerView.pickerCountry.frame.height - self.registerView.signUpButton.frame.height - 20*yScale)
        }
        
        self.selectedTextField = textField
        
        //se usuário mudar sua opção de continente, habilitar edição do textField de país
        if textField == self.registerView.continentText
        {
            self.registerView.countryText.isUserInteractionEnabled = true
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField){
        self.registerView.frame.origin.y = 0
        
        //se usuário marcar "I'd rather not say" no continente, marcar o mesmo para o país e bloquear ação nesse textField
        if textField == self.registerView.continentText && self.registerView.continentText.text == "I'd rather not say"
        {
            self.registerView.countryText.text = "I'd rather not say"
            self.registerView.countryText.isUserInteractionEnabled = false
        }
    }
    
    @objc func goBack(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    func setPickerAccessory() {
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: #selector(donePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        
        toolBar.setItems([spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        self.registerView.continentText.inputAccessoryView = toolBar
        self.registerView.countryText.inputAccessoryView = toolBar
        self.registerView.courseText.inputAccessoryView = toolBar
    }
    
    func setArrays()
    {
        continentList = ["I'd rather not say","Africa","Asia","Europe","North America","South America","Oceania"]
        
        countryListAfrica = ["I'd rather not say","Algeria", "Angola", "Benin", "Botswana", "Burkina", "Burundi", "Cameroon", "Cape Verde", "Central African Republic", "Chad", "Comoros", "Congo", "Democratic Republic of Congo", "Djibouti", "Egypt", "Equatorial Guinea", "Eritrea", "Ethiopia", "Gabon", "Gambia", "Ghana", "Guinea", "Guinea-Bissau", "Ivory Coast", "Kenya", "Lesotho", "Liberia", "Libya", "Madagascar", "Malawi", "Mali", "Mauritania", "Mauritius", "Morocco", "Mozambique", "Namibia", "Niger", "Nigeria", "Rwanda", "Sao Tome and Principe", "Senegal", "Seychelles", "Sierra Leone", "Somalia", "South Africa", "South Sudan", "Sudan", "Swaziland", "Tanzania", "Togo", "Tunisia", "Uganda", "Zambia", "Zimbabwe"]
        countryListAsia = ["I'd rather not say","Afghanistan", "Bahrain", "Bangladesh", "Bhutan", "Brunei", "Cambodia", "China", "East Timor", "India", "Indonesia", "Iran", "Iraq", "Israel", "Japan", "Jordan", "Kazakhstan", "North Korea", "South Korea", "Kuwait", "Kyrgyzstan", "Laos", "Lebanon", "Malaysia", "Maldives", "Mongolia", "Myanmar (Burma)", "Nepal", "Oman", "Pakistan", "Philippines", "Qatar", "Russian Federation", "Saudi Arabia", "Singapore", "Sri Lanka", "Syria", "Tajikistan", "Thailand", "Turkey", "Turkmenistan", "United Arab Emirates", "Uzbekistan", "Vietnam", "Yemen"]
        countryListEurope = ["I'd rather not say","Albania", "Andorra", "Armenia", "Austria", "Azerbaijan", "Belarus", "Belgium", "Bosnia and Herzegovina", "Bulgaria", "Croatia", "Cyprus", "Czech Republic", "Denmark", "Estonia", "Finland", "France", "Georgia", "Germany", "Greece", "Hungary", "Iceland", "Ireland", "Italy", "Latvia", "Liechtenstein", "Lithuania", "Luxembourg", "Macedonia", "Malta", "Moldova", "Monaco", "Montenegro", "Netherlands", "Norway", "Poland", "Portugal", "Romania", "San Marino", "Serbia", "Slovakia", "Slovenia", "Spain", "Sweden", "Switzerland", "Ukraine", "United Kingdom", "Vatican City"]
        countryListNorthAm = ["I'd rather not say","Antigua and Barbuda", "Bahamas", "Barbados", "Belize", "Canada", "Costa Rica", "Cuba", "Dominica", "Dominican Republic", "El Salvador", "Grenada", "Guatemala", "Haiti", "Honduras", "Jamaica", "Mexico", "Nicaragua", "Panama", "Saint Kitts and Nevis", "Saint Lucia", "Saint Vincent and the Grenadines", "Trinidad and Tobago", "United States"]
        countryListSouthAm = ["I'd rather not say","Argentina", "Bolivia", "Brazil", "Chile", "Colombia", "Ecuador", "Guyana", "Paraguay", "Peru", "Suriname", "Uruguay", "Venezuela"]
        countryListOceania = ["I'd rather not say","Australia", "Fiji", "Kiribati", "Marshall Islands", "Micronesia", "Nauru", "New Zealand", "Palau", "Papua New Guinea", "Samoa", "Solomon Islands", "Tonga", "Tuvalu", "Vanuatu"]
        
        courseList = ["I'd rather not say","Anthropology, Sociology or Philosophy", "Arts-related", "Business-related", "Communication studies", "Computer science/ IT/Technology", "Criminology", "Design", "Economics", "Education", "Engineering", "Geography", "Health-related", "History", "International relations", "Law", "Linguistics", "Math-related", "Natural Sciences", "Political science", "Psychology", "Theology"]
    }
}

