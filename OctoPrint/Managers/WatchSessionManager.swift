//
//  WatchSessionManager.swift
//  OctoPrint
//
//  Created by Jeremy Roberts on 10/22/17.
//  Copyright © 2017 Quiver Apps. All rights reserved.
//

import Foundation
import WatchConnectivity
import CommonCodePhone

class WatchSessionManager: NSObject {
    static let shared = WatchSessionManager()
    private var session = WCSession.default

    override init() {
        super.init()
    }

    func setupManager() {
        if WCSession.isSupported() {
            session.delegate = self
            session.activate()
        }
    }
}

extension WatchSessionManager: WCSessionDelegate {

    func updateApplicationContext(applicationContext: [String : AnyObject]) throws {
        if session.isPaired, session.isWatchAppInstalled {
            do {
                try session.updateApplicationContext(applicationContext)
            } catch let error {
                throw error
            }
        }
    }

    func sessionDidBecomeInactive(_ session: WCSession) {

    }

    func sessionDidDeactivate(_ session: WCSession) {

    }

    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState,
                 error: Error?) {
        if error == nil {
            NotificationCenter.default.post(
                name: NSNotification.Name(rawValue: Constants.Notifications.watchSessionReady), object: nil)
        }
    }

}
