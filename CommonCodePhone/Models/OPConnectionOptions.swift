//
//  OPConnectionOptions.swift
//  OctoPrint
//
//  Created by Jeremy Roberts on 10/15/17.
//  Copyright © 2017 Quiver Apps. All rights reserved.
//

import Foundation
public struct OPConnectionOptions: Codable {
    public let ports: [String]
    public let baudrates: [Int]
    public let printerProfiles: [OPPrinterProfiles]
    public let portPreference: String
    public let baudratePreference: Int
    public let printerProfilePreference: String
    public let autoconnect: Bool?
}
