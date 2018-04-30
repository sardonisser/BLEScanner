//
//  BLEDeviceDetailTableViewController.swift
//  BLEScanner
//
//  Created by Simon on 30.04.18.
//  Copyright © 2018 Simon J. All rights reserved.
//

import UIKit

class BLEDeviceDetailTableViewController: UITableViewController {
    
    var device : BLEDevice? {
        didSet {
            guard let device = device else { return }
            device.delegateDeviceDetail = self
        }
    }
    
    
    // MARK: - Initialization

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch(section) {
        case 0:
            return "Info"
        default:
            fatalError("requested section is out of range")
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch(section) {
        case 0:
            return 3
        default:
            fatalError("requested section is out of range")
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : UITableViewCell

        switch(indexPath.section) {
        case 0:
            cell = tableView.dequeueReusableCell(withIdentifier: "DeviceInfoCell")!
            populateDeviceInfoCell(cell, at: indexPath.row)
            break;
        default:
            fatalError("requested section is out of range")
        }

        return cell
    }
    
    private func populateDeviceInfoCell(_ cell: UITableViewCell, at row: Int) {
        switch(row) {
        case 0:
            cell.textLabel?.text = "Name"
            cell.detailTextLabel?.text = device?.name
            break
        case 1:
            cell.textLabel?.text = "UUID"
            cell.detailTextLabel?.text = device?.peripheral.identifier.uuidString
            break
        case 2:
            cell.textLabel?.text = "RSSI"
            cell.detailTextLabel?.text = (device != nil) ? (device!.rssi.stringValue + " dBm") : nil
            break
        default:
            break
        }
    }

}

extension BLEDeviceDetailTableViewController : BLEDeviceDelegate {
    func bleDevice(_ device: BLEDevice, didUpdateName newName: String?) {
        DispatchQueue.main.async {
            self.tableView.cellForRow(at: IndexPath(row: 0, section: 0))?.detailTextLabel?.text = newName
        }
    }
    
    func bleDevice(_ device: BLEDevice, didUpdateRSSI newRSSI: NSNumber) {
        DispatchQueue.main.async {
            self.tableView.cellForRow(at: IndexPath(row: 2, section: 0))?.detailTextLabel?.text = newRSSI.stringValue + " dBm"
        }
    }
}
