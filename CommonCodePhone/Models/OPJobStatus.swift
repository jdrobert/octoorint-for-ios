//
//  OPJobStatus.swift
//  OctoPrint
//
//  Created by Jeremy Roberts on 10/15/17.
//  Copyright © 2017 Quiver Apps. All rights reserved.
//

import Foundation

public struct OPJobStatus: Codable {
    let job: OPJobInformation
    let progress: OPJobProgressInformation
    let state: String
}
