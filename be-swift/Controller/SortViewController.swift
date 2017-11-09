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
    var codeToSort: Array<String> = []
    var challenge: Challenge!
    var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sortView = SortView(frame: CGRect.zero, titleText: self.challenge.tags[0] as! String, dismissButtonAction: #selector(SortViewController.dismissButton(_:)), helpButtonAction: #selector(SortViewController.helpButton(_:)), questionText: self.challenge.question, exampleCodeText: self.challenge.exampleCode, options: self.challenge.options as! Array<String>, correctAnswer: self.challenge.correctAnswer as! Array<String>)
        
//        sortView = SortView(frame: CGRect.zero, titleText: self.challenge.tags[0] as! String, dismissButtonAction: #selector(SortViewController.dismissButton(_:)), helpButtonAction: #selector(SortViewController.helpButton(_:)), questionText: "Sort the code below so it will build. \nPlease organize variables in alphabetic \norder.", exampleCodeText: self.challenge.exampleCode, options: self.challenge.options as! Array<String>, correctAnswer: self.challenge.correctAnswer as! Array<String>)
        
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        scrollView.contentSize = CGSize(width: self.view.frame.size.width, height: sortView.frame.height)
        self.view.addSubview(scrollView)
        
        scrollView.addSubview(sortView)
        //self.view.addSubview(sortView)
        //self.view = self.sortView
        self.sortView.sortTableView.dataSource = self
        self.sortView.sortTableView.delegate = self
        self.sortView.sortTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.sortView.sortTableView.isEditing = true
        self.codeToSort = self.sortView.codeToSort
        self.sortView.checkButton.addTarget(self, action: #selector(checkAnswer), for: .touchUpInside)
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
    
    @objc func checkAnswer() {
        self.sortView.sortTableView.isEditing = false
        
        print("RESPOSTA: \(codeToSort == self.challenge.correctAnswer as! Array<String>)")
        
        if codeToSort == self.challenge.correctAnswer as! Array<String> {
            
            let feedbackController = FeedbackViewController()
            present(feedbackController, animated: false, completion: nil)
            
        } else
        {
            //remove 'Check' button and add 'Try Again' button
            if self.sortView.checkButton.image(for: .normal) == UIImage(named: "continue")
            {
                self.sortView.checkButton.setBackgroundImage(UIImage(named: "tryAgain"), for: .normal)
            }  else
            {
                //Refresh challenge
            }
        }
    }
    
    @objc func dismissButton(_ sender: Any){
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func helpButton(_ sender: Any){
        let webView = WebDocumentationViewController()
        webView.url = URL(string: self.challenge.resource_link)!
        present(webView, animated: false, completion: nil)
    }
}

