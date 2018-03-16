//
//  StringExtension.swift
//  OctoPrint
//
//  Created by Jeremy Roberts on 3/16/18.
//  Copyright © 2018 Quiver Apps. All rights reserved.
//

import Foundation

extension String {
    static func localizedString(_ key: String) -> String {
        return NSLocalizedString(key, comment: "")
    }
}
