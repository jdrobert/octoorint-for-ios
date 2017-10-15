//
//  OPFile.swift
//  OctoPrint
//
//  Created by Jeremy Roberts on 10/15/17.
//  Copyright © 2017 Quiver Apps. All rights reserved.
//

import Foundation
public struct OPFile: Codable {
    let name: String?
    let path: String?
    let type: String?
    let typePath: [String:String]?
}
