//
//  OPCurrentConnection.swift
//  OctoPrint
//
//  Created by Jeremy Roberts on 10/15/17.
//  Copyright © 2017 Quiver Apps. All rights reserved.
//

import Foundation
public struct OPCurrentConnection: Codable {
    let state: String
    let port: String?
    let baudrate: Int?
    let printerProfile: String
}
