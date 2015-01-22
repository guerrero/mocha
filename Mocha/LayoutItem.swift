//
//  LayoutItem.swift
//  Mocha
//
//  Created by AG on 20/1/15.
//  Copyright (c) 2015 AG. All rights reserved.
//

import UIKit

class LayoutItem: NSObject, NSCoding {
    
    var name: String
    var color: UIColor = UIColor.whiteColor()
    var width: String = "20"
    var height: String = "20"
    
    init(name: String) {
        self.name = name
    }
    
    // NSCoding functions
    
    let nameKey = "name"
    let colorKey = "cost"
    let widthKey = "size"
    let heightKey = "height"
    
    required init(coder aDecoder: NSCoder) {
        self.name = aDecoder.decodeObjectForKey(nameKey) as String
        self.color = aDecoder.decodeObjectForKey(colorKey) as UIColor
        self.width = aDecoder.decodeObjectForKey(widthKey) as String
        self.height = aDecoder.decodeObjectForKey(heightKey) as String
        
        super.init() // subclass of another super.init(coder)
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(self.name, forKey: nameKey)
        aCoder.encodeObject(self.color, forKey: colorKey)
        aCoder.encodeObject(self.width, forKey: widthKey)
        aCoder.encodeObject(self.height, forKey: heightKey)
    }
}