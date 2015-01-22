//
//  ViewController.swift
//  Mocha
//
//  Created by AG on 20/1/15.
//  Copyright (c) 2015 AG. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITableViewDataSource {
    
    var itemList: ItemList!
    var itemListPath: String!
    
    // UI Elements
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var selectImageButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    // Elements data for tableView
    let customCellIdentifier = "CustomTableViewCell"
    
    // MARK: Loading functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Table View settings
        
        // Get ui design for table rows from xib file and set as cell identifier
        var nib = UINib(nibName: customCellIdentifier, bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: customCellIdentifier)
        
        tableView.rowHeight = 64
        
        
        // Try to load itemList from plist file and if it doesn't exists create it
        itemListPath = fileInDocumentsDirectory("itemList.plist")
        loadItemList(fromPath: itemListPath)

        self.navigationController?.navigationBarHidden = true
        
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        tableView.reloadData()
        loadItemList(fromPath: itemListPath)
    }
    
    // MARK: Buttons
    
    // Get an image from saved photos album to use as reference for the mockup
    @IBAction func selectImageButtonPressed(sender: AnyObject) {
        var imagePicker = UIImagePickerController()
        
        if UIImagePickerController.isSourceTypeAvailable(.SavedPhotosAlbum) {
            imagePicker.sourceType = .SavedPhotosAlbum
            imagePicker.delegate = self
            
            presentViewController(imagePicker, animated: true, completion: nil)
        }
    }
    
    // Create mockup in CSS and as layout
    @IBAction func getMockupButtonPressed(sender: AnyObject) {
    }
    
    // Return path for file in Documents folder by filename
    func fileInDocumentsDirectory(filename: String) -> String {
        var documentsFolderPath = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0] as String
        
        var filePath = documentsFolderPath.stringByAppendingPathComponent(filename)
        
        return filePath
    }
    
    
    // MARK: Image Picker
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        
        var sourceImage = info[UIImagePickerControllerOriginalImage] as UIImage
        
        imageView.image = sourceImage
        
        // Change button text for select image if image is already selected
        if selectImageButton.titleLabel?.text != "Change selected image" && imageView.image != nil {
            self.selectImageButton.setTitle("Change selected image", forState: .Normal)
        }
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: Table
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemList.items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier(customCellIdentifier) as CustomTableViewCell
        
        cell.classNameLabel.text = "\(itemList.items[indexPath.row].name)"
        
        cell.widthLabel.text! = "Width: \(itemList.items[indexPath.row].width)"
        cell.widthLabel.sizeToFit()
        cell.heightLabel.text! = "Height: \(itemList.items[indexPath.row].height)"
        cell.heightLabel.sizeToFit()
        
        cell.setIdColor(itemList.items[indexPath.row].color)
        cell.editingAccessoryType = .DisclosureIndicator
        
        return cell
    }
    
    // Execute an action if any tableView cell is pressed
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        // Store selected row and save itemList data to pass it to ItemViewController
        itemList.selectedRow = indexPath.row
        saveItemList(itemList, toPath: itemListPath)
        
        // Go to ItemViewController
        let itemViewController = self.storyboard?.instantiateViewControllerWithIdentifier("itemViewController") as ItemViewController
        
        self.navigationController?.pushViewController(itemViewController, animated: true)
    
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