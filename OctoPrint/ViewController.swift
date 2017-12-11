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

    private let dc = DiscoveryClient()

    override func viewDidLoad() {
        super.viewDidLoad()

        //NotificationCenter.default.addObserver(self, selector: #selector(syncWithWatch),
            //name: NSNotification.Name(rawValue: Constants.Notifications.watchSessionReady), object: nil)

        //WatchSessionManager.shared.setupManager()

        dc.startDiscovery(with: "_octoprint._tcp") { services in
            for service in services {
                if let hostname = service.hostName {
                    print(hostname)
                }

                print(service.name)
            }
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 10) { [weak self] in
            self?.dc.stopDiscovery()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @objc private func syncWithWatch() {
        let info = PrinterConnectionInfoStore()
        if let cachedValues = info.getCachedValues() {
            try? WatchSessionManager.shared.updateApplicationContext(
                applicationContext: ["connectionInfo":cachedValues])
        }

    }

}
