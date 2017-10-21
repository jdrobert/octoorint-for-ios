//
//  OPTemperatureTool.swift
//  OctoPrint
//
//  Created by Jeremy Roberts on 10/21/17.
//  Copyright © 2017 Quiver Apps. All rights reserved.
//

import Foundation

public struct OPTemperatureTool: Codable {
    public let actual: Double
    public let offset: Double
    public let target: Double
}
