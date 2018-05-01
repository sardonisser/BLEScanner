//
//  BLEDeviceTableViewCell.swift
//  BLEScanner
//
//  Created by Simon on 30.04.18.
//  Copyright © 2018 Simon J. All rights reserved.
//

import UIKit
import CoreBluetooth

class BLEDevicesListCell: UITableViewCell {

    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelUUID: UILabel!
    @IBOutlet weak var labelRSSI: UILabel!
    @IBOutlet weak var labelDateTime: UILabel!
    
    var device: BLEDevice? {
        didSet {
            guard let device = device else { return }
            device.delegateDevicesList = self
            
            self.labelUUID.text = BLEUIFormatter.formatDeviceUUID(device.uuid) // value won't change, no need for delegate method
            self.bleDevice(device, didUpdateName: device.name)
            self.bleDevice(device, didUpdateRSSI: device.rssi)
            self.bleDevice(device, didUpdateDateTime: device.dateTime)
        }
    }

}

extension BLEDevicesListCell: BLEDeviceDelegate {
    func bleDevice(_ device: BLEDevice, didUpdateName newName: String?) {
        DispatchQueue.main.async {
            self.labelName.text = BLEUIFormatter.formatDeviceName(newName)
        }
    }
    
    func bleDevice(_ device: BLEDevice, didUpdateRSSI newRSSI: NSNumber) {
        DispatchQueue.main.async {
            self.labelRSSI.text = BLEUIFormatter.formatDeviceRSSI(newRSSI)
        }
    }
    
    func bleDevice(_ device: BLEDevice, didUpdateDateTime newDateTime: Date) {
        DispatchQueue.main.async {
            self.labelDateTime.text = BLEUIFormatter.formatDeviceDateTime(newDateTime)
        }
    }
}
