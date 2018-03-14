//
//  Enums.swift
//  OctoPrint
//
//  Created by Jeremy Roberts on 3/14/18.
//  Copyright © 2018 Quiver Apps. All rights reserved.
//

import Foundation

public enum PrinterState: String {
    case none = "Offline"
    case connected = "Connected"
    case openSerial = "Opening serial port"
    case detectSerial = "Detecting serial port"
    case detectBaudRate = "Detecting baudrate"
    case connecting = "Connecting"
    case operational = "Operational"
    case printing = "Printing"
    case printingFromSD = "Printing from SD"
    case streamingFile = "Sending file to SD"
    case paused = "Paused"
    case closed = "Closed"
    case error = "Error:"
    case closedWithError = "Offline:"
    case transferringFile = "Transferring file to SD"

    static let connectedStates =
        [connected, operational, printing, printingFromSD, streamingFile, paused, transferringFile]
    static let disconnectedStates = [none, closed, error, closedWithError]
    static let connectingStates = [openSerial, detectSerial, detectBaudRate, connecting]
}
