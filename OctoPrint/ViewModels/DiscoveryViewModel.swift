//
//  DiscoveryViewModel.swift
//  OctoPrint
//
//  Created by Jeremy Roberts on 12/11/17.
//  Copyright © 2017 Quiver Apps. All rights reserved.
//

import Foundation

class DiscoveryViewModel {
    func format(hostName:String?) -> String? {
        if let hn = hostName {
            var hostNameArray = hn.components(separatedBy: ".")
            hostNameArray.removeLast()

            let cleanHostName = hostNameArray.joined(separator: ".")
            return String(format:"http://%@", cleanHostName)
        }

        return nil

    }
}
