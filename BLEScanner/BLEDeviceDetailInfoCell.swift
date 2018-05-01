//
//  BLEDeviceDetailInfoCell.swift
//  BLEScanner
//
//  Created by Simon on 30.04.18.
//  Copyright © 2018 Simon J. All rights reserved.
//

import UIKit

//@IBDesignable
class BLEDeviceDetailInfoCell: UITableViewCell {
    
    @IBInspectable
    var labelSeparatorOffset: CGFloat = -20
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateLabelSeparatorOffset()
    }

    func updateLabelSeparatorOffset() {
        self.textLabel?.frame.origin.x += labelSeparatorOffset
        self.detailTextLabel?.frame.origin.x += labelSeparatorOffset
    }

}
