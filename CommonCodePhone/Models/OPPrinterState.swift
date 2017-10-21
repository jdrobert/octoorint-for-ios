//
//  OPPrinterState.swift
//  OctoPrint
//
//  Created by Jeremy Roberts on 10/21/17.
//  Copyright © 2017 Quiver Apps. All rights reserved.
//

import Foundation

public struct OPPrinterState: Codable {
    public let sd: OPSDState
    public let state: OPState
    public let temperature: OPTemperature
}
