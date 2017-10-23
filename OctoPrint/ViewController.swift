//
//  ViewController.swift
//  OctoPrint
//
//  Created by Jeremy Roberts on 10/15/17.
//  Copyright © 2017 Quiver Apps. All rights reserved.
//

import UIKit
import CommonCodePhone

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(syncWithWatch), name: NSNotification.Name(rawValue: Constants.Notifications.watchSessionReady), object: nil)
        
        WatchSessionManager.shared.setupManager()
        
        let connectionInfo = PrinterConnectionInfoStore()
        connectionInfo.ipAddress = "http://octopi.local"
        connectionInfo.apiKey = "772B1B4E41FC41AD8962698BE5D6925D"
        
        //WatchSessionManager.shared
        
        //syncWithWatch()
        
        NetworkManager.shared.getPrinterState(success: { (version) in
            print(version)
        }) {
            print("failure")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc private func syncWithWatch() {
        let info = PrinterConnectionInfoStore()
        if let cachedValues = info.getCachedValues() {
            try? WatchSessionManager.shared.updateApplicationContext(applicationContext: ["connectionInfo":cachedValues])
        }
        
        
    }


}

