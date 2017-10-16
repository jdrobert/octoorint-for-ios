//
//  OPJobStatus.swift
//  OctoPrint
//
//  Created by Jeremy Roberts on 10/15/17.
//  Copyright © 2017 Quiver Apps. All rights reserved.
//

import Foundation

public struct OPJobStatus: Codable {
    public let job: OPJobInformation
    public let progress: OPJobProgressInformation
    public let state: String
}
