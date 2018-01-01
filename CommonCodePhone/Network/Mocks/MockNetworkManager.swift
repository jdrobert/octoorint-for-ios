//
//  MockNetworkManager.swift
//  OctoPrint
//
//  Created by Jeremy Roberts on 12/28/17.
//  Copyright © 2017 Quiver Apps. All rights reserved.
//

import Foundation

public class MockNetworkManager: NetworkProtocol {
    public static let shared: NetworkProtocol = {
        return MockNetworkManager()
    }()

    public func getJobProgress(success: @escaping (OPJobStatus) -> Void, failure: @escaping () -> Void) {
        if let progress = getPrintingJobProgress() {
            success(progress)
        }

    }

    public func getConnectionInformation(success: @escaping (OPConnectionInformation) -> Void,
                                         failure: @escaping () -> Void) {

    }

    public func getVersionNumber(success: @escaping (OPVersion) -> Void, failure: @escaping () -> Void) {

    }

    public func getPrinterState(success: @escaping (OPPrinterState) -> Void, failure: @escaping () -> Void) {

    }

}

// MARK: Job progress
extension MockNetworkManager {
    private func getPrintingJobProgress() -> OPJobStatus? {
        let progressJSON = """
        {
            "job": {
                "averagePrintTime": null,
                "estimatedPrintTime": 9990.805517099921,
                "filament": {
                    "tool0": {
                        "length": 10968.067410000931,
                        "volume": 0
                    }
                },
                "file": {
                    "date": 1508167216,
                    "name": "food_scoops.gcode",
                    "origin": "local",
                    "path": "Cat_Prints/food_scoops.gcode",
                    "size": 6307692
                },
                "lastPrintTime": null
            },
            "progress": {
                "completion": 1.795569599783883,
                "filepos": 113259,
                "printTime": 612,
                "printTimeLeft": 10263,
                "printTimeLeftOrigin": "mixed-analysis"
            },
            "state": "Printing"
        }
        """

        return decodeObject(from: progressJSON.data(using: .utf8))
    }

}

extension MockNetworkManager {
    private func decodeObject<T>(from response:Data?) -> T? where T:Decodable {
        do {
            if let responseValue = response {
                let decoder = JSONDecoder()
                return try decoder.decode(T.self, from: responseValue)
            }
        } catch {
            print(error)
        }

        return nil
    }
}
