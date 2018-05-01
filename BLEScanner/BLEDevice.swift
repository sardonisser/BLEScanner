//
//  BLEDevice.swift
//  BLEScanner
//
//  Created by Simon on 30.04.18.
//  Copyright © 2018 Simon J. All rights reserved.
//

import Foundation
import CoreBluetooth

protocol BLEDeviceDelegate: class {
    func bleDevice(_ device: BLEDevice, didUpdateName newName: String?)
    func bleDevice(_ device: BLEDevice, didUpdateRSSI newRSSI: NSNumber)
    func bleDevice(_ device: BLEDevice, didUpdateDateTime newDateTime: Date)
}

class BLEDevice: NSObject {
    
    weak var delegateDevicesList: BLEDeviceDelegate?
    weak var delegateDeviceDetail: BLEDeviceDelegate?
    
    let peripheral: CBPeripheral
    
    var name: String? {
        didSet {
            delegateDevicesList?.bleDevice(self, didUpdateName: name)
            delegateDeviceDetail?.bleDevice(self, didUpdateName: name)
        }
    }
    var rssi: NSNumber! {
        didSet {
            delegateDevicesList?.bleDevice(self, didUpdateRSSI: rssi)
            delegateDeviceDetail?.bleDevice(self, didUpdateRSSI: rssi)
        }
    }
    var dateTime: Date! {
        didSet {
            delegateDevicesList?.bleDevice(self, didUpdateDateTime: dateTime)
            delegateDeviceDetail?.bleDevice(self, didUpdateDateTime: dateTime)
        }
    }
    
    init(peripheral: CBPeripheral) {
        self.peripheral = peripheral
        self.name = peripheral.name
        super.init()
        peripheral.delegate = self
    }
    
}

extension BLEDevice: CBPeripheralDelegate {
    
    func peripheralDidUpdateName(_ peripheral: CBPeripheral) {
        self.name = peripheral.name
    }
    
    // MARK: Discovery
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverDescriptorsFor characteristic: CBCharacteristic, error: Error?) {
        
    }
    
    
    // MARK: Update
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor descriptor: CBDescriptor, error: Error?) {
        
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateNotificationStateFor characteristic: CBCharacteristic, error: Error?) {
        
    }
    
}
