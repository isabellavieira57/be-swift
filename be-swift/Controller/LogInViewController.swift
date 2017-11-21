//
//  LogInViewController.swift
//  be-swift
//
//  Created by Ana Müller on 11/19/17.
//  Copyright © 2017 Isabella Vieira. All rights reserved.
//

import Foundation
import UIKit

class LogInViewController: UIViewController
{
    var loginView: LoginView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginView = LoginView(goBack: #selector(goBack), logIn: #selector(logIn))
        self.view.addSubview(loginView)
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(tap)
    }
    
    @objc func logIn()
    {
        if self.loginView.emailText.text == "" || self.loginView.passwordText.text == ""
        {
            let alert = UIAlertController(title: "Ops!", message: "Please type your e-mail and your password", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
            //Firebase login
        }
    }
    
    @objc func goBack()
    {
        self.dismiss(animated: false, completion: nil)
    }
    
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }

}

