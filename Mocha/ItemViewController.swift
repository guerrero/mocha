//
//  ItemViewController.swift
//  Mocha
//
//  Created by AG on 20/1/15.
//  Copyright (c) 2015 AG. All rights reserved.
//

import UIKit

class ItemViewController: UIViewController {
    
    var itemList: ItemList!
    var currentItem: LayoutItem!
    var itemListPath: String!

    @IBOutlet weak var itemNameLabel: UITextField!
    @IBOutlet weak var itemWidthLabel: UITextField!
    @IBOutlet weak var itemHeightLabel: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        itemListPath = fileInDocumentsDirectory("itemList.plist")
        loadItemList(fromPath: itemListPath)
        
        currentItem = itemList.items[itemList.selectedRow!]
        
        itemNameLabel.text = itemList.items[itemList.selectedRow!].name
        itemWidthLabel.text = itemList.items[itemList.selectedRow!].width
        itemHeightLabel.text = itemList.items[itemList.selectedRow!].height
        
    }
    
    
    @IBAction func saveChangesButtonPressed(sender: AnyObject) {
        
        currentItem.name = itemNameLabel.text
        currentItem.width = itemWidthLabel.text
        currentItem.height = itemHeightLabel.text
        
        saveItemList(itemList, toPath: itemListPath)
        
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    
    @IBAction func discardChangesButtonPressed(sender: AnyObject) {
        
        self.navigationController?.popToRootViewControllerAnimated(true)
    }

    // Return path for file in Documents folder by filename
    func fileInDocumentsDirectory(filename: String) -> String {
        var documentsFolderPath = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0] as String
        
        var filePath = documentsFolderPath.stringByAppendingPathComponent(filename)
        
        return filePath
    }
    
    // Save and load item list data
    func saveItemList(itemList: ItemList, toPath path: String) -> Bool {
        let success = NSKeyedArchiver.archiveRootObject(itemList, toFile: path)
        return success
    }
    
    func loadItemList(fromPath path: String) -> Bool {
        if let itemList = NSKeyedUnarchiver.unarchiveObjectWithFile(path) as ItemList? {
            self.itemList = itemList
            return true
        } else {
            self.itemList = ItemList()
            return false
        }
    }
}
