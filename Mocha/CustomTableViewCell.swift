//
//  CustomTableViewCell.swift
//  Mocha
//
//  Created by AG on 20/1/15.
//  Copyright (c) 2015 AG. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    @IBOutlet weak var classNameLabel: UILabel!
    @IBOutlet weak var widthLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var colorView: UIView!
    
    // Set colorView as rounded view with border color and inner layer
    func setIdColor(color: UIColor) {
        colorView.layer.borderColor = UIColor.blackColor().CGColor
        colorView.layer.borderWidth = 2
        colorView.layer.cornerRadius = colorView.frame.size.height / 2
        
        var innerElement: CALayer = CALayer()
            innerElement.frame = CGRectMake(2, 2, colorView.frame.size.width - 4, colorView.frame.size.height - 4)
            innerElement.cornerRadius = (colorView.frame.size.width - 2) / 2
            innerElement.borderColor = UIColor.whiteColor().CGColor
            innerElement.borderWidth = 2
            innerElement.backgroundColor = color.CGColor
        
        colorView.layer.addSublayer(innerElement)
    }
}
