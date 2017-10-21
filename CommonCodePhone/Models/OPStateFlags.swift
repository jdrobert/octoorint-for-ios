//
//  OPStateFlags.swift
//  OctoPrint
//
//  Created by Jeremy Roberts on 10/21/17.
//  Copyright © 2017 Quiver Apps. All rights reserved.
//

import Foundation

public struct OPStateFlags: Codable {
    public let closedOrError: Bool
    public let error: Bool
    public let operational: Bool
    public let paused: Bool
    public let printing: Bool
    public let ready: Bool
    public let sdReady: Bool
}
