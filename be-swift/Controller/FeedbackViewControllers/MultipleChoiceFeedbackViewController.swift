//
//  MultipleChoiceFeedbackViewController.swift
//  be-swift
//
//  Created by Ana Müller on 11/10/17.
//  Copyright © 2017 Isabella Vieira. All rights reserved.
//

import Foundation
import UIKit

class MultipleChoiceFeedbackViewController: FeedbackViewController
{
    var userAnswer: String!
    var correctAnswer: String!
    var answerIsRight: Bool!
    var challengeMultChoice: Challenge!
    var multChoiceFeedView = FeedbackView()
    var scrollView: UIScrollView!
    var sizeView: CGFloat!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        multChoiceFeedView = FeedbackView(titleText: self.challengeMultChoice.tags[0] as! String, dismissButtonAction: #selector(dismissButton), helpButtonAction: #selector(helpButton), questionText: self.challengeMultChoice.question, exampleCodeText: self.challengeMultChoice.exampleCode)
        
        //self.view.addSubview(multChoiceFeedView)
        
        //Set feedback view labels
        self.multChoiceFeedView.setLabelUserAnswer(labelText: self.userAnswer)
        setLabels()
        self.multChoiceFeedView.addSubview(self.multChoiceFeedView.labelExplanation)
        
        //Set continue button
        self.multChoiceFeedView.setButton(continueButtonAction: #selector(continueButton(_:)))
        self.multChoiceFeedView.addSubview(self.multChoiceFeedView.buttonContinue)
        sizeView = multChoiceFeedView.sizeView
        
        self.multChoiceFeedView.frame = CGRect(x: 0, y: 0, width: self.multChoiceFeedView.frame.width, height: sizeView)
        
        //Set scrollView
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        scrollView.contentSize = CGSize(width: self.view.frame.size.width, height: sizeView)
        self.scrollView.backgroundColor = UIColor(red:0.96, green:0.96, blue:0.96, alpha:1.0)
        self.view.addSubview(scrollView)
        scrollView.addSubview(self.multChoiceFeedView)
    }
    
    func setLabels()
    {
        self.multChoiceFeedView.setLabelUserAnswer(labelText: self.userAnswer)
        self.multChoiceFeedView.setCorrectChallengeAnswer(labelText: self.correctAnswer)
        
        if answerIsRight == true
        {
            //add label when the user's answer is correct
            self.multChoiceFeedView.addSubview(self.multChoiceFeedView.labelCorrectUserAnswer)
            
            //set the explanation label's parameters
            self.multChoiceFeedView.setLabelExplanation(labelText: self.challengeMultChoice.feedbackAnswer, previousLabel: self.multChoiceFeedView.labelCorrectUserAnswer)
            
        } else {
            // add labels when the user's answer is incorrect
            self.multChoiceFeedView.addSubview(self.multChoiceFeedView.labelWrongUserAnswer)
            self.multChoiceFeedView.addSubview(self.multChoiceFeedView.labelCorrectAnswer)
            
            //set the explanation label's parameters
            self.multChoiceFeedView.setLabelExplanation(labelText: self.challengeMultChoice.feedbackAnswer, previousLabel: self.multChoiceFeedView.labelCorrectAnswer)
        }
    }
//
//// O sizeView é usado para determinar o tamanho da scrollView. Como ele estava dando erro na FeedbackView, tentei settar na View que o tamanho da scrollView é igual ao tamanho da tela do dispositivo do usuário. Aí, aqui no controller, eu atualizaria o tamanho da scrollView, caso necessário, na função abaixo. Isso também não deu certo (o erro que apareceu foi no AppDelegate.
////
//    func updateButtonPosition()
//    {
//        //Variables to automatically update the position and size of elements according to the user's device
//        let widhtiPhoneSE: CGFloat = 320
//        let heightiPhoneSE: CGFloat = 568
//        let screenSize = UIScreen.main.bounds
//        let xScale = screenSize.width/widhtiPhoneSE
//        let yScale = screenSize.height/heightiPhoneSE
//
//        let yPostionPreviousLabel = self.multChoiceFeedView.labelExplanation.frame.origin.y
//
//        //se o elemento anterior (explanation label) estiver posicionado abaixo do limite da tela do dispositivo, mudaremos a altura do frame da view. Toda a tela vai ser acessível através da scrollView, cujo tamanho é igual ao da frame da multChoiceFeedView.
//
//        if yPostionPreviousLabel > 568*yScale
//        {
//            self.multChoiceFeedView.buttonContinue.frame.origin = CGPoint(x: 16*xScale, y: yPostionPreviousLabel + 62*yScale)
//            self.multChoiceFeedView.sizeView = self.multChoiceFeedView.buttonContinue.frame.minY + 62*yScale
//            self.multChoiceFeedView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: self.multChoiceFeedView.sizeView)
//        }
//    }
    
    func getVariables(challenge: Challenge, userAnswer: String, correctAnswer: String, answerIsRight: Bool)
    {
        self.challengeMultChoice = challenge
        self.userAnswer = userAnswer
        self.correctAnswer = correctAnswer
        self.answerIsRight = answerIsRight
    }
    
    @objc func dismissButton(_ sender: Any)
    {
        self.view.window!.rootViewController?.dismiss(animated: false, completion: nil)
    }
    
    @objc func helpButton(_ sender: Any)
    {
        let webView = WebDocumentationViewController()
        webView.url = URL(string: self.challengeMultChoice.resource_link)!
        present(webView, animated: false, completion: nil)
    }
    
    @objc func continueButton(_ sender: Any)
    {
        print("DISMMISS")
        self.view.window!.rootViewController?.dismiss(animated: false, completion: nil)
    }
    
}
