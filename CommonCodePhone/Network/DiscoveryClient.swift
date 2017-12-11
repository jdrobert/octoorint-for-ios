//
//  DiscoveryClient.swift
//  OctoPrint
//
//  Created by Jeremy Roberts on 10/23/17.
//  Copyright © 2017 Quiver Apps. All rights reserved.
//

import Foundation

public class DiscoveryClient: NSObject {

    private let netServiceBrowser = NetServiceBrowser()
    private var services = [NetService]()
    private var resolvedServices = [NetService]()
    private var success: (([NetService]) -> Void)?
    public var isSearching = false

    public func startDiscovery(with type:String, success:@escaping ([NetService]) -> Void) {
        if !isSearching {
            netServiceBrowser.delegate = self
            self.success = success
            isSearching = true
            netServiceBrowser.searchForServices(ofType: type, inDomain: "local")
        }
    }

    public func stopDiscovery() {
        if let successHandler = success {
            successHandler(resolvedServices)
        }

        netServiceBrowser.stop()
        services.removeAll()
        resolvedServices.removeAll()
        isSearching = false
    }

}

extension DiscoveryClient: NetServiceBrowserDelegate {

}

extension DiscoveryClient: NetServiceDelegate {
    public func netServiceBrowser(_ browser: NetServiceBrowser,
                                  didFind service: NetService, moreComing: Bool) {
        services.append(service)
        service.delegate = self
        service.resolve(withTimeout: 1)
        service.startMonitoring()
    }

    public func netServiceDidResolveAddress(_ sender: NetService) {
        resolvedServices.append(sender)
    }
}
