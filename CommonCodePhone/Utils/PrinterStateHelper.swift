//
//  PrinterStateMapper.swift
//  OctoPrint
//
//  Created by Jeremy Roberts on 3/14/18.
//  Copyright © 2018 Quiver Apps. All rights reserved.
//

import Foundation

public class PrinterStateHelper {
    static func mapToEnum(from string:String) -> PrinterState {
        if let printerState = PrinterState(rawValue: string) {
            return printerState
        }
        return PrinterState.none
    }

    public static func isConnected(_ printerState:String) -> Bool {
        return does(stateList: PrinterState.connectedStates, contain: printerState)
    }

    public static func isDisconnected(_ printerState:String) -> Bool {
        return does(stateList: PrinterState.disconnectedStates, contain: printerState)
    }

    public static func isConnecting(_ printerState:String) -> Bool {
        return does(stateList: PrinterState.connectingStates, contain: printerState)
    }

    private static func does(stateList:[PrinterState], contain printerState:String) -> Bool {
        for state in stateList {
            if printerState.range(of: state.rawValue) != nil {
                return true
            }
        }

        return false
    }
}
