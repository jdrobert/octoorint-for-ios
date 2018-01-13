//
//  DashboardViewModel.swift
//  OctoPrint
//
//  Created by Jeremy Roberts on 1/12/18.
//  Copyright © 2018 Quiver Apps. All rights reserved.
//

import UIKit
import CommonCodePhone

class DashboardViewModel {

    func getProfileName(for id:String, profiles:[OPPrinterProfiles]) -> String {
        for profile in profiles where profile.id == id {
            return profile.name
        }

        return "Default"
    }

    func getBaudratesArray(_ baudrates: [Int]) -> [String] {
        var baudRatesStr = [String]()
        for baudrate in baudrates {
            baudRatesStr.append(String(baudrate))
        }
        return baudRatesStr
    }

    func getProfileNames(_ profiles: [OPPrinterProfiles]) -> [String] {
        var printerProfiles = [String]()
        for profile in profiles {
            printerProfiles.append(profile.name)
        }
        return printerProfiles
    }

    func getPortName(_ connection: OPConnectionInformation) -> String {
        if !connection.options.ports.isEmpty {
            return connection.options.portPreference
        }

        return "AUTO"
    }
}
