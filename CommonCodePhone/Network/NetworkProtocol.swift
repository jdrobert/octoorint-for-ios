//
//  NetworkProtocol.swift
//  OctoPrint
//
//  Created by Jeremy Roberts on 12/28/17.
//  Copyright © 2017 Quiver Apps. All rights reserved.
//

import Foundation

public protocol NetworkProtocol {
    static var shared: NetworkProtocol {get}

    func getJobProgress(success: @escaping (OPJobStatus) -> Void, failure: @escaping () -> Void)
    func getConnectionInformation(success: @escaping (OPConnectionInformation) -> Void,
                                  failure: @escaping () -> Void)
    func getVersionNumber(success: @escaping (OPVersion) -> Void, failure: @escaping () -> Void)
    func getPrinterState(success: @escaping (OPPrinterState) -> Void, failure: @escaping () -> Void)
    func connect(to port:String, baudrate:Int, printerProfile:String, completion: @escaping () -> Void)
    func disconnect(completion: @escaping () -> Void)
}
