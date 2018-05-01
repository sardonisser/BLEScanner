//
//  BLEUIFormatter.swift
//  BLEScanner
//
//  Created by Simon on 01.05.18.
//  Copyright © 2018 Simon J. All rights reserved.
//

import Foundation

class BLEUIFormatter {
    
    static let deviceDateTimeFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "y-MM-dd HH:mm:ss.SSS"
        return df
    }()
    
    
    static func formatDeviceName(_ name: String?) -> String? {
        return name
    }
    
    static func formatDeviceUUID(_ uuid: UUID) -> String {
        return uuid.uuidString
    }
    
    static func formatDeviceRSSI(_ rssi: NSNumber) -> String {
        return rssi.stringValue + " dBm"
    }
    
    static func formatDeviceDateTime(_ date: Date) -> String {
        return deviceDateTimeFormatter.string(from: date)
    }
    
}
