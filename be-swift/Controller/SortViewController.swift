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
    
    var arrayOptions = ["let mySize = Size()", "print(mySize.height)", "struct Size {", "    var height = 10 }"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sortView = SortView()
        
        self.view.addSubview(sortView)
        self.view = self.sortView
        
        self.sortView.sortTableView.dataSource = self
        self.sortView.sortTableView.delegate = self
    
        self.sortView.sortTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        self.sortView.sortTableView.isEditing = true
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrayOptions.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.backgroundColor = UIColor(red:0.16, green:0.17, blue:0.21, alpha:1.0)
        cell.textLabel?.text = self.arrayOptions[indexPath.row]
        cell.textLabel?.textColor = UIColor.white
        labelDidChange(cell.textLabel!)
        
        return cell
    }
    
    //Enables rearrengement of lines
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    //Rearrenges lines
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        let rearrangedLine = arrayOptions[sourceIndexPath.row]
        arrayOptions.remove(at: sourceIndexPath.row)
        arrayOptions.insert(rearrangedLine, at: destinationIndexPath.row)
        
        NSLog("%@", "\(sourceIndexPath.row) => \(destinationIndexPath.row) \(arrayOptions)")
        self.sortView.sortTableView.reloadData()
    }
    
    //Disable delete buttons when editing the order of cells
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .none
    }
    
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    //Função para colorir caracteres
    func labelDidChange(_ label: UILabel) {
        let attrStr = NSMutableAttributedString(string: label.text!)
        let inputLength = attrStr.string.characters.count
        
        let searchString : NSArray = NSArray.init(objects: "func","var", "let", "if", "else", "return", "init", "true", "false", "class", "struct")
        for i in 0...searchString.count-1 {
            let string : String = searchString.object(at: i) as! String
            let searchLength = string.characters.count
            var range = NSRange(location: 0, length: attrStr.length)
            
            while (range.location != NSNotFound) {
                range = (attrStr.string as NSString).range(of: string, options: [], range: range)
                if (range.location != NSNotFound) {
                    attrStr.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor(red:0.76, green:0.20, blue:0.60, alpha:1.0), range: NSRange(location: range.location, length: searchLength))
                    range = NSRange(location: range.location + range.length, length: inputLength - (range.location + range.length))
                    label.attributedText = attrStr
                }
            }
        }
        
        let searchStringTypes : NSArray = NSArray.init(objects: "Int","Double", "String", "print")
        for i in 0...searchStringTypes.count-1 {
            let string : String = searchStringTypes.object(at: i) as! String
            let searchLength = string.characters.count
            var range = NSRange(location: 0, length: attrStr.length)
            while (range.location != NSNotFound) {
                range = (attrStr.string as NSString).range(of: string, options: [], range: range)
                if (range.location != NSNotFound) {
                    attrStr.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor(red:0.00, green:0.69, blue:0.79, alpha:1.0), range: NSRange(location: range.location, length: searchLength))
                    range = NSRange(location: range.location + range.length, length: inputLength - (range.location + range.length))
                    label.attributedText = attrStr
                }
            }
        }
        
        let searchInts : NSArray = NSArray.init(objects: "0","1", "2", "3", "4", "5", "6", "7", "8", "9")
        for i in 0...searchInts.count-1 {
            let string : String = searchInts.object(at: i) as! String
            let searchLength = string.characters.count
            var range = NSRange(location: 0, length: attrStr.length)
            while (range.location != NSNotFound) {
                range = (attrStr.string as NSString).range(of: string, options: [], range: range)
                if (range.location != NSNotFound) {
                    attrStr.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor(red:0.55, green:0.51, blue:0.81, alpha:1.0), range: NSRange(location: range.location, length: searchLength))
                    range = NSRange(location: range.location + range.length, length: inputLength - (range.location + range.length))
                    label.attributedText = attrStr
                }
            }
        }
    }
    
}
