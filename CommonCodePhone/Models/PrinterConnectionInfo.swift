//
//  PrinterConnectionInfo.swift
//  OctoPrint
//
//  Created by Jeremy Roberts on 10/23/17.
//  Copyright © 2017 Quiver Apps. All rights reserved.
//

import Foundation

public struct PrinterConnectionInfo: Codable {
    public let ipAddress: String
    public let apiKey: String
    public let name: String

    public init (name:String, ipAddress:String, apiKey:String) {
        self.name = name
        self.ipAddress = ipAddress
        self.apiKey = apiKey
    }
}
