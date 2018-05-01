//
//  BLEDevice+UUID.swift
//  BLEScanner
//
//  Created by Simon on 01.05.18.
//  Copyright © 2018 Simon J. All rights reserved.
//

import Foundation

extension BLEDevice {
    var uuid: UUID {
        return self.peripheral.identifier
    }
}
