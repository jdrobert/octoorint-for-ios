//
//  OPJobProgressInformation.swift
//  OctoPrint
//
//  Created by Jeremy Roberts on 10/15/17.
//  Copyright © 2017 Quiver Apps. All rights reserved.
//

import Foundation
public struct OPJobProgressInformation: Codable {
    let completion: Float?
    let filepos: Int?
    let printTime: Int?
    let printTimeLeft: Int?
}
