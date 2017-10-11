//
//  ViewController.swift
//  be-swift
//
//  Created by Isabella Vieira on 08/10/17.
//  Copyright © 2017 Isabella Vieira. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var inicialView: View!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        inicialView = View(frame: CGRect.zero)
        self.view.addSubview(inicialView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

