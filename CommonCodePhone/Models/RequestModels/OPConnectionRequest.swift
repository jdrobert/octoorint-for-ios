//
//  OPConnectionRequest.swift
//  CommonCodePhone
//
//  Created by Jeremy Roberts on 3/16/18.
//  Copyright © 2018 Quiver Apps. All rights reserved.
//

import Foundation

struct OPConnectionRequest {
    let command = "connect"
    let port: String
    let baudrate: Int
    let printerProfile: String

    init(port: String, baudrate: Int, printerProfile: String) {
        self.port = port
        self.baudrate = baudrate
        self.printerProfile = printerProfile
    }
}
