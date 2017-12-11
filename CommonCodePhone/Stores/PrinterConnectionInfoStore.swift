//
//  PrinterConnectionInfoStore.swift
//  OctoPrint
//
//  Created by Jeremy Roberts on 10/21/17.
//  Copyright © 2017 Quiver Apps. All rights reserved.
//

import Foundation

public class PrinterConnectionInfoStore {
    private let ipAddressKey = "ipAddress"
    private let apiKeyKey = "apiKey"

    public init() {

    }

    public init(data: NSData) {
        let decoder = JSONDecoder()
        if let connectionInfo = try? decoder.decode(PrinterConnectionInfo.self, from: data as Data) {
            ipAddress = connectionInfo.ipAddress
            apiKey = connectionInfo.apiKey
        }
    }

    public var ipAddress: String? {
        get {
            return UserDefaults.standard.string(forKey: ipAddressKey)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: ipAddressKey)
        }
    }

    public var apiKey: String? {
        get {
            return UserDefaults.standard.string(forKey: apiKeyKey)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: apiKeyKey)
        }
    }

    public func getCachedValues() -> NSData? {
        let info = PrinterConnectionInfo(ipAddress: ipAddress ?? "", apiKey: apiKey ?? "")
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(info) as NSData {
            return encoded
        }

        return nil
    }
}
