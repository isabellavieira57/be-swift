//
//  WelcomeViewController.swift
//  be-swift
//
//  Created by Ana Müller on 11/19/17.
//  Copyright © 2017 Isabella Vieira. All rights reserved.
//
import Foundation
import UIKit

class WelcomeViewController: UIViewController
{
    var logoImage: UIImageView!
    var registerButton: UIButton!
    var logInButton: UIButton!
    var logInLabel: UILabel!
    
    let widhtiPhoneSE: CGFloat = 320
    let heightiPhoneSE: CGFloat = 568
    let screenSize = UIScreen.main.bounds
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red:0.31, green:0.49, blue:0.95, alpha:1.0)
        
        setElements()
    }
    
    func setElements()
    {
        let xScale = screenSize.width/widhtiPhoneSE
        let yScale = screenSize.height/heightiPhoneSE
        
        logoImage = UIImageView(frame: CGRect(x: 20*xScale, y: 140*yScale, width: 280*xScale, height: 50*yScale))
        logoImage.image = UIImage(named: "mainLogo")
        
        registerButton = UIButton(image: "createAccount", frame: CGRect(x: 15, y: 340, width: 288, height: 46), target: self)
        registerButton.addTarget(self, action: #selector(createAccount), for: .touchUpInside)
        
        logInLabel = UILabel(text: "Already an user?", font: "SanFranciscoText-Medium", fontSize: 16, aligment: .center, textColor: UIColor.white, frame: CGRect(x: 0, y: 410, width: 320, height: 20))
        
        logInButton = UIButton(image: "mainLogIn", frame: CGRect(x: 15, y: 445, width: 288, height: 46), target: self)
        logInButton.addTarget(self, action: #selector(logIn), for: .touchUpInside)
        print("FRAME LOG IN ", logInButton.frame)
        print("FRAME REGISTER ", registerButton.frame)
        
        
        self.view.addSubview(logoImage)
        self.view.addSubview(registerButton)
        self.view.addSubview(logInLabel)
        self.view.addSubview(logInButton)
    }
    
    @objc func createAccount()
    {
        let controller = RegisterViewController()
        present(controller, animated: true, completion: nil)
    }
    
    @objc func logIn()
    {
        let controller = LoginViewController()
        present(controller, animated: true, completion: nil)
    }
}
