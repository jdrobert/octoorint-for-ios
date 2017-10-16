//
//  OPFile.swift
//  OctoPrint
//
//  Created by Jeremy Roberts on 10/15/17.
//  Copyright © 2017 Quiver Apps. All rights reserved.
//

import Foundation
public struct OPFile: Codable {
    public let name: String?
    public let path: String?
    public let type: String?
    public let typePath: [String:String]?
}
