//
//  OPJobInformation.swift
//  OctoPrint
//
//  Created by Jeremy Roberts on 10/15/17.
//  Copyright © 2017 Quiver Apps. All rights reserved.
//

import Foundation
public struct OPJobInformation: Codable {
    let averagePrintTime: Int?
    let estimatedPrintTime: Int?
    let lastPrintTime: Int?
    let filament: OPFilament?
    let file: OPFile
}
