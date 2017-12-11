//
//  WatchSessionManager.swift
//  OctoPrintWatch Extension
//
//  Created by Jeremy Roberts on 10/22/17.
//  Copyright © 2017 Quiver Apps. All rights reserved.
//

import Foundation
import WatchConnectivity
import CommonCodeWatch

class WatchSessionManager: NSObject {
    static let shared = WatchSessionManager()
    private let session = WCSession.default

    override init() {
        super.init()
    }

    func setupManager() {
        session.delegate = self
        session.activate()
    }
}

extension WatchSessionManager: WCSessionDelegate {

    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState,
                 error: Error?) {

    }

    func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String : Any]) {
        if let connectionInfo = applicationContext["connectionInfo"] as? NSData {
            _ = PrinterConnectionInfoStore(data:connectionInfo)
        }
        print(applicationContext)
    }
}
