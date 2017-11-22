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
    
    var emailField:            UITextField!
    var senhaField:            UITextField!
    var erroMessageLabel:      UILabel!
    var user = User()

    override func viewDidLoad() {
        super.viewDidLoad()
        if User.sharedInstance.checkLogedIn() {
            print ("Login Done")
        }
    }
    
    func isValidEmail(string: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: string)
    }
    
    
    // Botao de login
    func loginButtonPress() {
        guard (emailField.text != "") else {
            erroMessageLabel.text = "email invalido"
            erroMessageLabel.isHidden = false
            return
        }
        guard (isValidEmail(string: emailField.text!)) else {
            erroMessageLabel.text = "email invalido"
            erroMessageLabel.isHidden = false
            return
        }
        guard (senhaField.text != "") else {
            erroMessageLabel.text = "senha invalida"
            erroMessageLabel.isHidden = false
            return
        }
        user.login(email: emailField.text!, password: senhaField.text!)
    }
    
    
    // Botao de esqueceu a senha
    func forgotPassword() {
        if ((emailField.text!.isEmpty)) {
            let alert = UIAlertController(title: "Please, fill in your email!", message: "", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(defaultAction)
            self.present(alert,animated: true, completion: nil)
        } else {
            Auth.auth().sendPasswordReset(withEmail: emailField.text!) { error in
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
