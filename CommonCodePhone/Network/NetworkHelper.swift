//
//  NetworkHelper.swift
//  OctoPrint
//
//  Created by Jeremy Roberts on 12/28/17.
//  Copyright © 2017 Quiver Apps. All rights reserved.
//

import Foundation

public class NetworkHelper {

    private var networkManager: NetworkProtocol?

    public static let helperInstance = NetworkHelper()
    public static var shared: NetworkProtocol {
        if let man = helperInstance.networkManager {
            return man
        }

        return NetworkManager.shared
    }

    public func setNetworkManager(networkManager:NetworkProtocol) {
        self.networkManager = networkManager
    }
}
