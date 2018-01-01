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

        //NotificationCenter.default.addObserver(self, selector: #selector(syncWithWatch),
            //name: NSNotification.Name(rawValue: Constants.Notifications.watchSessionReady), object: nil)

        //WatchSessionManager.shared.setupManager()

        NetworkHelper.shared.getJobProgress(success: { (progress) in
            print(progress)
        }, failure: {

        })

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
