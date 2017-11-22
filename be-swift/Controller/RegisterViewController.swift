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

class RegisterViewController: UIViewController  {
    
    var emailField:            UITextField!
    var passwordField:            UITextField!
    var confirmPasswordField:    UITextField!
    var nameField:           UITextField!
    var countryField:           UITextField!
    var majorField:           UITextField!
    var user = User()


    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func isValidEmail(string: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: string)
    }
    
    
    // Botao de confirmar cadastro
    func confirmCadastroButton() {
        let email = emailField.text!.lowercased()
        let finalemail = email.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        
        if (passwordField.text != confirmPasswordField.text) {
            let alert = UIAlertController(title: "Both passwords are different!", message: "Please, try again.", preferredStyle:.alert)
            let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
        }
        
        if ((passwordField.text?.count)! < 6) {
            let alert = UIAlertController(title: "The password needs to have at least 6 digits.", message: "Please, try again", preferredStyle:.alert)
            let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
        }
        
        if finalemail.isEmpty {
            let alert = UIAlertController(title: "Email field is empty!", message: "Please, try again", preferredStyle:.alert)
            let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
        } else if ( isValidEmail(string: finalemail)) {
            user.register(email: finalemail, password: passwordField.text!)
    
//            Auth.auth()?.createUser(withEmail: emailField.text!, password: passwordField.text!, completion: { (user, error) in
//                if error == nil {
//                    print("DAO - usuario criado")
//                    PessoaDAO.sharedInstance.loadUsuario(email: self.emailField.text!, senha: self.senhaField.text!)
//                    self.performSegue(withIdentifier: "cadastroBack", sender: sender)
//                } else {
//                    print(error?.localizedDescription ?? "DAO - erro no registro")
//                    let alert = UIAlertController(title: "Email Inválido", message: "O email digitado já existe.", preferredStyle:.alert)
//                    let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
//                    alert.addAction(ok)
//                    self.present(alert, animated: true, completion: nil)
//                }
//            })
            
        } else {
            //Email não válido
            let alert = UIAlertController(title: "Invalid email!", message: "Please, try again.", preferredStyle:.alert)
            let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
        }
        
      
        // salva no banco os dados do formulario
        
        user.saveRegistration(name: nameField.text!, email: emailField.text!, password: passwordField.text!, country: countryField.text!, major: majorField.text!)
    }
}
