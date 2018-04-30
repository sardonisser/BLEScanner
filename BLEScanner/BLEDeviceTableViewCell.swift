//
//  BLEDeviceTableViewCell.swift
//  BLEScanner
//
//  Created by Simon on 30.04.18.
//  Copyright © 2018 Simon J. All rights reserved.
//

import UIKit
import CoreBluetooth

class BLEDeviceTableViewCell: UITableViewCell {

    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelUUID: UILabel!
    @IBOutlet weak var labelRSSI: UILabel!
    
    var device : BLEDevice? {
        didSet {
            guard let device = device else { return }
            device.delegate = self
            labelName.text = device.name
            labelUUID.text = device.peripheral.identifier.uuidString
            labelRSSI.text = device.rssi.stringValue
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension BLEDeviceTableViewCell : BLEDeviceDelegate {
    func bleDevice(_ device: BLEDevice, didUpdateName newName: String?) {
        DispatchQueue.main.async {
            self.labelName.text = newName
        }
    }
    
    func bleDevice(_ device: BLEDevice, didUpdateRSSI newRSSI: NSNumber) {
        DispatchQueue.main.async {
            self.labelRSSI.text = newRSSI.stringValue
        }
    }
}
