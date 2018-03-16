//
//  UIColorExtension.swift
//  OctoPrint
//
//  Created by Jeremy Roberts on 3/15/18.
//  Copyright © 2018 Quiver Apps. All rights reserved.
//

import UIKit

extension UIColor {
    static func named(_ name:String) -> UIColor {
        return UIColor(named: name) ?? UIColor.purple
    }
}
