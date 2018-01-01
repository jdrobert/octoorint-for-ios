//
//  InterfaceController.swift
//  OctoPrintWatch Extension
//
//  Created by Jeremy Roberts on 10/15/17.
//  Copyright © 2017 Quiver Apps. All rights reserved.
//

import WatchKit
import Foundation
import CommonCodeWatch

class InterfaceController: WKInterfaceController {

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)

        /*WKExtension.shared().scheduleBackgroundRefresh(withPreferredDate: Date().addingTimeInterval(60),
            userInfo: nil, scheduledCompletion: { (error: Error?) in
            if error == nil {
                print("background refresh scheduled")
            }
        })*/

        WatchSessionManager.shared.setupManager()

        addMenuItem(with: .repeat, title: "Refresh", action: #selector(getPrinterState))

        // Configure interface objects here.
    }

    @objc private func getPrinterState() {

        NetworkHelper.shared.getVersionNumber(success: { [weak self] (version) in
            self?.presentAlert(withTitle: "Success", message: "", preferredStyle: .alert,
                               actions: [WKAlertAction(title: "OK", style: .default, handler: {})])

            print(version)
        }, failure: { [weak self] in
            self?.presentAlert(withTitle: "Failure", message: "", preferredStyle: .alert,
                               actions: [WKAlertAction(title: "OK", style: .default, handler: {})])
            print("failure")
        })
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        let server = CLKComplicationServer.sharedInstance()
        if let complications = server.activeComplications {
            for complication in complications {
                server.reloadTimeline(for: complication)
            }
        }

    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
