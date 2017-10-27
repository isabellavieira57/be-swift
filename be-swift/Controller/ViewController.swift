//
//  ViewController.swift
//  be-swift
//
//  Created by Isabella Vieira on 08/10/17.
//  Copyright © 2017 Isabella Vieira. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class ViewController: UIViewController {

    var blankField: BlankFieldView!
    var multipleChoice: MultipleChoiceView!
    var multipleChoiceController: MultipleChoiceController!
    var sortView: SortView!
    var sortController: SortViewController!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        blankField = BlankFieldView(frame: self.view.bounds, titleText: "Constants", dismissButtonAction: #selector(ViewController.dismissButton(_:)), helpButtonAction: #selector(ViewController.helpButton(_:)), questionText: "Once this code is executed, how \nmany items will numbers contain? \nmany items will numbers contain? \nmany items will numbers contain? \nmany items will numbers contain? \nmany items will numbers contain? \nmany items will numbers contain?", exampleCodeText: "func calculateDiscount (age: Int, \nprice: Double, discount: Double) \n->  Double { \nvar value = 0.0 \nif (age>60 || age<10) { ")
        
//        var screenHeight = UIScreen.main.bounds.height
        
        //TODO: AJUSTAR FRAMES
//        sortView = SortView(frame: CGRect(x: 0, y: 64, width: 321, height: screenHeight - 64 ))
        
//        multipleChoice = MultipleChoiceView(frame: CGRect(x: 0, y: 315, width: 321, height: 300 ))
        
//        self.view.addSubview(blankField)
//        self.view.addSubview(sortView)
//        self.view.addSubview(multipleChoice)
        
            //let challenges: ChallengeDAO
            //challenges = ChallengeDAO()
            //challenges.getChallenges()
        
            self.getChallenges()

        }
    
    override func viewDidAppear(_ animated: Bool) {
        let controller = SortViewController()
        present(controller, animated: false, completion: nil)
    }

    @objc func dismissButton(_ sender: Any){
        //mandar para a home
    }
    
    @objc func helpButton(_ sender: Any){
        //mandar para doc apple
        let webView = WebDocumentationViewController()
        present(webView, animated: false, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func getChallenges () {
        /*if (!AppDelegate.isAlreadyLaunchedOnce) {
         FirebaseApp.configure()
         AppDelegate.isAlreadyLaunchedOnce = true
         }*/
        
        var ref = Database.database().reference().child("be-swift")
        var refHandle: UInt!
        
        print ("GET CHALLENGES")
        
        refHandle = ref.child("be-swift").observe(DataEventType.value, with: { (snapshot) in
            print ("SNAPSHOT")
            let dataDict = snapshot.value as? [String : AnyObject] ?? [:]
            print (">>> DATADICT: \(dataDict)")
            for item in dataDict {
                print (">>> ITEM: \(item)")
            }
        })
        
    }

}

