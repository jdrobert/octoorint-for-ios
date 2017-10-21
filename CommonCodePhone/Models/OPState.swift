//
//  OPState.swift
//  OctoPrint
//
//  Created by Jeremy Roberts on 10/21/17.
//  Copyright © 2017 Quiver Apps. All rights reserved.
//

import Foundation

public struct OPState: Codable {
    public let flags: OPStateFlags
    public let text: String
}
