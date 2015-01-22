//
//  swift
//  Mocha
//
//  Created by AG on 20/1/15.
//  Copyright (c) 2015 AG. All rights reserved.
//

import UIKit

class ItemList: NSObject {

    var items: [LayoutItem]
    var selectedRow: Int?
    var lastViewedIndex: Int?
    
    // keys for NScoder
    let itemArrayKey = "itemArray"
    let lastViewedIndexKey = "lastViewedIndex"
    let selectedRowKey = "selectedRow"
    
    override init() {
        items = [LayoutItem]()
        lastViewedIndex = nil
        selectedRow = nil
        
        // Declare each layout item for tableView
        items.append(LayoutItem(name: "untitled1"))
            items[0].color = UIColor.cyanColor()
            items[0].width = "20%"
            items[0].height = "20%"
        
        items.append(LayoutItem(name: "untitled2"))
            items[1].color = UIColor.magentaColor()
            items[1].width = "20%"
            items[1].height = "20%"
        
        items.append(LayoutItem(name: "untitled3"))
            items[2].color = UIColor.yellowColor()
            items[2].width = "20%"
            items[2].height = "20%"
        
        super.init()
    }
    
    required init(coder aDecoder: NSCoder) {
        items = aDecoder.decodeObjectForKey(itemArrayKey) as [LayoutItem]
        lastViewedIndex = aDecoder.decodeObjectForKey(lastViewedIndexKey) as Int?
        selectedRow = aDecoder.decodeObjectForKey(selectedRowKey) as Int?
        
        super.init()
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(items, forKey: itemArrayKey)
        aCoder.encodeObject(lastViewedIndex, forKey: lastViewedIndexKey)
        aCoder.encodeObject(selectedRow, forKey: selectedRowKey)
    }
}
