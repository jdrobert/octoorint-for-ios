//
//  OPConnectionOptions.swift
//  OctoPrint
//
//  Created by Jeremy Roberts on 10/15/17.
//  Copyright © 2017 Quiver Apps. All rights reserved.
//

import Foundation
public struct OPConnectionOptions: Codable {
    let ports: [String]
    let baudrates: [Int]
    let printerProfiles: [OPPrinterProfiles]
    let portPreference: String
    let baudratePreference: Int
    let printerProfilePreference: String
    let autoconnect: Bool?
}
