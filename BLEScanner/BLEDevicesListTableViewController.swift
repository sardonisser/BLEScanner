//
//  BLEDevicesTableViewController.swift
//  BLEScanner
//
//  Created by Simon on 30.04.18.
//  Copyright © 2018 Simon J. All rights reserved.
//

import UIKit
import CoreBluetooth

class BLEDevicesListTableViewController: UITableViewController {
    
    private var activityIndicator : UIActivityIndicatorView!
    private var barButtonStartRefresh : UIBarButtonItem!
    private var barButtonStopRefresh : UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        activityIndicator.hidesWhenStopped = true
        
        self.barButtonStartRefresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshPressed))
        self.barButtonStopRefresh = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(refreshPressed))
        self.navigationItem.rightBarButtonItems = [barButtonStartRefresh, UIBarButtonItem(customView: activityIndicator)]
        
        BLEManager.shared.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    // MARK: - Refresh
    
    @objc func refreshPressed() {
        if BLEManager.shared.scanning {
            BLEManager.shared.stopScan()
            activityIndicator.stopAnimating()
            self.navigationItem.rightBarButtonItems![0] = barButtonStartRefresh
        } else {
            BLEManager.shared.startScan(services: nil, options: [CBCentralManagerScanOptionAllowDuplicatesKey:true])
            activityIndicator.startAnimating()
            self.navigationItem.rightBarButtonItems![0] = barButtonStopRefresh
        }
    }
    
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDeviceDetail" {
            let detailVC = segue.destination as! BLEDeviceDetailTableViewController
            let selectedRow = self.tableView.indexPathForSelectedRow!.row
            detailVC.device = BLEManager.shared.devices[selectedRow]
        }
    }
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return BLEManager.shared.devices.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DeviceCell", for: indexPath) as! BLEDevicesListCell

        let device = BLEManager.shared.devices[indexPath.row]
        cell.device = device

        return cell
    }

}

extension BLEDevicesListTableViewController : BLEManagerDelegate {
    func bleManager(_ manager: BLEManager, didAddDeviceAt index: Int) {
        DispatchQueue.main.async {
            self.tableView.beginUpdates()
            self.tableView.insertRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
            self.tableView.endUpdates()
        }
    }
}
