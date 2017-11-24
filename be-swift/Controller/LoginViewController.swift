//
//  LoginViewController.swift
//  be-swift
//
//  Created by Isabella Vieira on 21/11/17.
//  Copyright © 2017 Isabella Vieira. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth

protocol UserHandler {
    func loginUser (success:Bool)
}

class LoginViewController: UIViewController, UserHandler, UITextFieldDelegate {
 
    var loginView: LoginView!
    var indicator = UIActivityIndicatorView()
    var erroMessageLabel: UILabel!
    var userDAO = UserDAO()
    var success: Bool?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginView = LoginView(goBack: #selector(goBack), logIn: #selector(logIn))
        self.view.addSubview(loginView)
        
        self.loginView.emailText.delegate = self
        self.loginView.passwordText.delegate = self
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(tap)
    }
    
    func isValidEmail(string: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: string)
    }
    
    func activityIndicator() {
        indicator = UIActivityIndicatorView()
        indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        indicator.center = self.view.center
        DispatchQueue.main.async {
            self.view.addSubview(self.indicator)
        }
    }
    
    
    @objc func logIn () {
        
        if (self.loginView.emailText.text! == "" ) || (self.loginView.passwordText.text! == "") || (!isValidEmail(string: self.loginView.emailText.text!)) {
            let alert = UIAlertController(title: "Ops!", message: "Please type your e-mail and your password", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        } else {
            self.activityIndicator()
            
            userDAO.loadUser(handler: self, email: self.loginView.emailText.text!, password: self.loginView.passwordText.text!)
            print (">>>>>>>>>sucess loginuser: \(self.success)")
            print ("email: \(self.loginView.emailText.text)")
            print ("senha: \(self.loginView.passwordText.text!)")
        }
    }
    
    func loginUser(success: Bool) {
        print ("sucess loginuser HANDLER: \(success)")
        self.success = success
        indicator.stopAnimating()
        indicator.hidesWhenStopped = true
        print ("sucess loginuser HANDLER CASSE: \(self.success)")
        
        if (self.success == true) {
            print("LOGIN CONTROLLER - You have successfully logged in")
            
            let viewController = ViewController()
            let delegate = UIApplication.shared.delegate as! AppDelegate
            let window = delegate.window
            window?.rootViewController = viewController
            self.present(viewController, animated: true, completion: nil)
            
        } else if (success == false) {
            print("Login falhooou")
            let alert = UIAlertController(title: "Login Failed!", message: "Please, check your username and password", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(defaultAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @objc func goBack() {
        self.dismiss(animated: false, completion: nil)
    }
    
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        return true
    }
    
    // Botao de esqueceu a senha
    func forgotPassword() {
        if ((self.loginView.emailText.text!.isEmpty)) {
            let alert = UIAlertController(title: "Please, fill in your email!", message: "", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(defaultAction)
            self.present(alert,animated: true, completion: nil)
        } else {
            Auth.auth().sendPasswordReset(withEmail: self.loginView.emailText.text!) { error in
                if (error == nil) {
                    let alert = UIAlertController(title: "An email was sent to you!", message: "Please, check your inbox.", preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alert.addAction(defaultAction)
                    self.present(alert,animated: true, completion: nil)
                } else {
                    let alert = UIAlertController(title: "Error!", message: "Please try again!", preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alert.addAction(defaultAction)
                    self.present(alert,animated: true, completion: nil)
                }
            }
        }
    }
}
