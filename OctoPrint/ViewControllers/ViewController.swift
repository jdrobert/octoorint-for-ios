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

    @IBOutlet weak private var connectionInfoHeightConstraint: NSLayoutConstraint!
    private let connectionInfoExpandedHeight: CGFloat = 182.0
    private let connectionInfoCollapsedHeight: CGFloat = 0.0
    private let connectionInfo = PrinterConnectionInfoStore()
    private var itemPicker: ItemPicker?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = connectionInfo.name
        //connectionInfoPickerHeightConstraint.constant = connectionInfoPickerCollapsedHeight

        //NotificationCenter.default.addObserver(self, selector: #selector(syncWithWatch),
            //name: NSNotification.Name(rawValue: Constants.Notifications.watchSessionReady), object: nil)

        //WatchSessionManager.shared.setupManager()

        NetworkHelper.shared.getConnectionInformation(success: { connectionInfo in
            print(connectionInfo)
        }, failure: {

        })

        itemPicker = ItemPicker(containerView: UIApplication.shared.keyWindow?.rootViewController?.view)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

    }

    private func showPicker(for items:[String]) {
        itemPicker?.showPicker(for: items, done: { selectedItem in
            print(selectedItem)
        }, cancel: nil)
    }

    @IBAction func connectionInfoHeaderTapAction(tapGesture: UITapGestureRecognizer) {
        UIView.animate(withDuration: 0.25) { [unowned self] in
            if self.connectionInfoHeightConstraint.constant == 0 {
                self.connectionInfoHeightConstraint.constant = self.connectionInfoExpandedHeight
            } else {
                self.connectionInfoHeightConstraint.constant = self.connectionInfoCollapsedHeight
            }

            self.view.layoutIfNeeded()
        }
    }

    @objc private func syncWithWatch() {
        if let cachedValues = connectionInfo.getCachedValues() {
            try? WatchSessionManager.shared.updateApplicationContext(
                applicationContext: ["connectionInfo":cachedValues])
        }

    }
}
