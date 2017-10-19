//
//  SortViewController.swift
//  be-swift
//
//  Created by Ana Müller on 10/18/17.
//  Copyright © 2017 Isabella Vieira. All rights reserved.
//

import UIKit

class SortViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var sortView: SortView!
    
    var arrayOptions = ["line 1", "line 2", "line 3", "line 4", "line 5"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sortView = SortView(frame: self.view.bounds)
//        self.view = self.sortView
        
        self.sortView.sortTableView.dataSource = self
        self.sortView.sortTableView.delegate = self
        
        self.sortView.sortTableView.isEditing = true
        
        self.view.addSubview(sortView)
//        self.sortView.sortTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrayOptions.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = arrayOptions[indexPath.row]
        
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
