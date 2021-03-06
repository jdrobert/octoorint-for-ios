//
//  OPCurrentConnection.swift
//  OctoPrint
//
//  Created by Jeremy Roberts on 10/15/17.
//  Copyright © 2017 Quiver Apps. All rights reserved.
//

import Foundation
public struct OPCurrentConnection: Codable {
    public let state: String
    public let port: String?
    public let baudrate: Int?
    public let printerProfile: String
}
