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
   
    var multipleChoice: MultipleChoiceView!
//    var multipleChoiceController: MultipleChoiceController!
    var sortView: SortView!
    var sortController: SortViewController!
    var levelController: LevelController!

    override func viewDidLoad() {
        print (">>> VIEW DID LOAD VIEW CONTROLLER")
        super.viewDidLoad()
        
//        var screenHeight = UIScreen.main.bounds.height
        
        //TODO: AJUSTAR FRAMES
//        sortView = SortView(frame: CGRect(x: 0, y: 64, width: 321, height: screenHeight - 64 ))
        
//        multipleChoice = MultipleChoiceView(frame: CGRect(x: 0, y: 315, width: 321, height: 300 ))
        
        }
    
    override func viewDidAppear(_ animated: Bool) {
        let controller = BlankFieldViewController()
        present(controller, animated: false, completion: nil)
//        
//        let levelController = LevelController()
//        levelController.viewDidLoad()
    }

    @objc func dismissButton(_ sender: Any){
        //mandar para a home
    }
    
    @objc func helpButton(_ sender: Any){
        //mandar para doc apple

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

