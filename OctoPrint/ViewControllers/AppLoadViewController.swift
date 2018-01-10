//
//  AppLoadViewController.swift
//  OctoPrint
//
//  Created by Jeremy Roberts on 1/7/18.
//  Copyright © 2018 Quiver Apps. All rights reserved.
//

import UIKit
import CommonCodePhone

class AppLoadViewController: UIViewController {
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let info = PrinterConnectionInfoStore()

        if
            info.ipAddress != nil,
            info.apiKey != nil,
            let vc = storyboard?.instantiateViewController(
                withIdentifier: Constants.StoryboardIDs.mainTabController) {
            UIApplication.shared.keyWindow?.rootViewController = vc
        } else if let vc = storyboard?.instantiateViewController(
            withIdentifier: Constants.StoryboardIDs.discoveryVCNav) {
            UIApplication.shared.keyWindow?.rootViewController = vc
        }
    }
}
