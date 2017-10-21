//
//  OPTemperature.swift
//  OctoPrint
//
//  Created by Jeremy Roberts on 10/21/17.
//  Copyright © 2017 Quiver Apps. All rights reserved.
//

import Foundation
public struct OPTemperature: Codable {
    public let bed: OPTemperatureTool
    public let tool0: OPTemperatureTool
}
