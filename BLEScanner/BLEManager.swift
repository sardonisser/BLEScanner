//
//  BLEManager.swift
//  BLEScanner
//
//  Created by Simon on 30.04.18.
//  Copyright © 2018 Simon J. All rights reserved.
//

import Foundation
import CoreBluetooth

protocol BLEManagerDelegate: class {
    func bleManager(_ manager: BLEManager, didAddDeviceAt index: Int)
}

class BLEManager: NSObject {
    
    static let shared = BLEManager()
    
    weak var delegate: BLEManagerDelegate?
    var devices = [BLEDevice]()
    
    private var centralManager: CBCentralManager!
    private var bleReady = false
    private(set) var scanning = false
    private var timer: Timer?
    
    private override init() {
        super.init()
        self.centralManager = CBCentralManager(delegate: self, queue: DispatchQueue.global(qos: .userInitiated))
    }
    
    // MARK: Scanning
    
    func startScan(services: [CBUUID]?, options: [String : Any]?, timeout: TimeInterval? = nil) {
        guard bleReady else { print("[BLEManager] > bluetooth not initialized"); return }
        guard !scanning else { print("[BLEManager] > scan already in progress"); return }
        
        centralManager.scanForPeripherals(withServices: services, options: options)
        if let timeout = timeout {
            self.timer = Timer.scheduledTimer(withTimeInterval: timeout, repeats: false) { _ in self.stopScan() }
        }
        
        scanning = true
        print("[BLEManager] scan started")
    }
    
    func stopScan() {
        guard scanning else { print("[BLEManager] > scan has not been started"); return }
        
        self.timer?.invalidate()
        centralManager.stopScan()
        
        scanning = false
        print("[BLEManager] scan stopped")
    }
    
}

extension BLEManager: CBCentralManagerDelegate {
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        var device = devices.first(where: { $0.peripheral === peripheral })
        let isNewDevice = device == nil
        
        if isNewDevice {
            // new device, instantiate and add to devices list
            print("[BLEManager] new peripheral: \(peripheral)")
            print(advertisementData)
            
            device = BLEDevice(peripheral: peripheral)
            self.devices.append(device!)
        }
        
        device!.rssi = RSSI
        device!.dateTime = Date()
        
        if isNewDevice {
            delegate?.bleManager(self, didAddDeviceAt: self.devices.count-1)
        }
    }
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        print("centralManagerDidUpdateState -> \(central.state.rawValue)")
        
        switch(central.state) {
        case .poweredOn:
            bleReady = true
            break
        
        case .unknown:
            fallthrough
        case .resetting:
            fallthrough
        case .unsupported:
            fallthrough
        case .unauthorized:
            fallthrough
        case .poweredOff:
            bleReady = false
            break
        }
    }
}
