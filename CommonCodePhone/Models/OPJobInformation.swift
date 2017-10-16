//
//  OPJobInformation.swift
//  OctoPrint
//
//  Created by Jeremy Roberts on 10/15/17.
//  Copyright © 2017 Quiver Apps. All rights reserved.
//

import Foundation
public struct OPJobInformation: Codable {
    public let averagePrintTime: Double?
    public let estimatedPrintTime: Double?
    public let lastPrintTime: Double?
    public let filament: OPFilament?
    public let file: OPFile
}
