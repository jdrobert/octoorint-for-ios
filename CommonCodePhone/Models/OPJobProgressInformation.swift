//
//  OPJobProgressInformation.swift
//  OctoPrint
//
//  Created by Jeremy Roberts on 10/15/17.
//  Copyright © 2017 Quiver Apps. All rights reserved.
//

import Foundation
public struct OPJobProgressInformation: Codable {
    public let completion: Float?
    public let filepos: Int?
    public let printTime: Int?
    public let printTimeLeft: Int?
}
