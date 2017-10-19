//
//  SortView.swift
//  be-swift
//
//  Created by Isabella Vieira on 08/10/17.
//  Copyright © 2017 Isabella Vieira. All rights reserved.
//

import Foundation
import UIKit

class SortView: View {
    
    var sortTableView: UITableView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
//        var screenSize = UIScreen.main.bounds
//        var screenHeight = screenSize.height
//        var screenWidth = screenSize.width
        
        //teste
        
        self.backgroundColor = UIColor.lightGray
        
        sortTableView = UITableView(frame: CGRect(x: 0, y: 0, width: 321, height: 400))
        
        self.addSubview(sortTableView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class SortViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var sortView: SortView!
    
    var arrayOptions = ["line 1", "line 2", "line 3", "line 4", "line 5"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.sortView.sortTableView.isEditing = true
        
        self.sortView = SortView()
        self.view = self.sortView
        
        self.sortView.sortTableView.dataSource = self
        self.sortView.sortTableView.delegate = self
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrayOptions.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        
        cell?.textLabel?.text = arrayOptions[indexPath.row]
        
        return cell!
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
    
}

