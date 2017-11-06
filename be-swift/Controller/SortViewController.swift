//
//  SortViewController.swift
//  be-swift
//
//  Created by Ana Müller on 10/19/17.
//  Copyright © 2017 Isabella Vieira. All rights reserved.
//

import Foundation
import UIKit

class SortViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var sortView: SortView!
    var codeToSort = [""]
    var correctAnswer = [""]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sortView = SortView(frame: CGRect.zero, titleText: "Exemplo Sort View", dismissButtonAction: #selector(dismissButton), helpButtonAction: #selector(helpButton), questionText: "Pergunta?", exampleCodeText: "", options: ["let mySize = Size()", "print(mySize.height)", "struct Size {", "    var height = 10 }"], correctAnswer: ["struct Size {", "    var height = 10 }", "let mySize = Size()", "print(mySize.height)"])
        
        self.view.addSubview(sortView)
        self.view = self.sortView
        
        self.sortView.sortTableView.dataSource = self
        self.sortView.sortTableView.delegate = self
        
        self.sortView.sortTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        self.sortView.sortTableView.isEditing = true
        
        self.codeToSort = self.sortView.codeToSort
        self.correctAnswer = self.sortView.correctAnswer
        
        //        sortView.checkButton.addTarget(self, action: #selector(checkAnswer), for: .touchUpInside)
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return codeToSort.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.backgroundColor = UIColor(red:0.16, green:0.17, blue:0.21, alpha:1.0)
        cell.textLabel?.text = self.codeToSort[indexPath.row]
        cell.textLabel?.textColor = UIColor.white
        self.sortView.view.labelDidChange(cell.textLabel!)
        //        labelDidChange(cell.textLabel!)
        
        return cell
    }
    
    //Enables rearrengement of lines
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    //Rearrenges lines
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        let rearrangedLine = codeToSort[sourceIndexPath.row]
        codeToSort.remove(at: sourceIndexPath.row)
        codeToSort.insert(rearrangedLine, at: destinationIndexPath.row)
        
        NSLog("%@", "\(sourceIndexPath.row) => \(destinationIndexPath.row) \(codeToSort)")
        self.sortView.sortTableView.reloadData()
    }
    
    //Disable delete buttons when editing the order of cells
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .none
    }
    
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    @objc func checkAnswer()
    {
        self.sortView.sortTableView.isEditing = false
        
        if codeToSort == correctAnswer
        {
            //feedbackView with message "You answered correctly..."
        } else
        {
            //remove 'Check' button and add 'Try Again' button
        }
    }
    
    @objc func dismissButton()
    {
        //        let controller = ViewController()
        //        present(controller, animated: true, completion: nil)
    }
    
    @objc func helpButton()
    {
        //        let webView = WebDocumentationViewController()
        //        present(webView, animated: false, completion: nil)
    }
    
}

