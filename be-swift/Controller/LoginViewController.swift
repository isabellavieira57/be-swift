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

class LoginViewController: UIViewController {
    
    var loginView: LoginView!
    
    var erroMessageLabel:      UILabel!
    var user = User()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginView = LoginView(goBack: #selector(goBack), logIn: #selector(logIn))
        self.view.addSubview(loginView)
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(tap)
    }
    
    func isValidEmail(string: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: string)
    }
    
    
    @objc func logIn () {
        
        if (self.loginView.emailText.text! == "" ) || (self.loginView.passwordText.text! == "") || (!isValidEmail(string: self.loginView.emailText.text!)) {
            let alert = UIAlertController(title: "Ops!", message: "Please type your e-mail and your password", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
            //Firebase login
            user.login(email: self.loginView.emailText.text!, password: self.loginView.passwordText.text!)
        }
    }
    
    @objc func goBack()
    {
        self.dismiss(animated: false, completion: nil)
    }
    
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
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
                    let alert = UIAlertController(title: "Error!", message: "Pleasem try again!", preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alert.addAction(defaultAction)
                    self.present(alert,animated: true, completion: nil)
                    
                }
            }
        }
    }
    
    
}
