//
//  NetworkManager.swift
//  OctoPrint
//
//  Created by Jeremy Roberts on 10/15/17.
//  Copyright © 2017 Quiver Apps. All rights reserved.
//

import Foundation
import Alamofire

public class NetworkManager {
    public static let shared = NetworkManager()
    private let sessionManager: SessionManager
    private lazy var baseURL: String = {
        return String(format:"%@/api",self.connectionInfo.ipAddress ?? "")
    }()

    private let connectionInfo = PrinterConnectionInfoStore()

    init() {
        let config = URLSessionConfiguration.default

        if let apiKey = connectionInfo.apiKey {
            config.httpAdditionalHeaders = ["X-Api-Key":apiKey]
        }

        sessionManager = Alamofire.SessionManager(configuration: config)
    }

    public func getJobProgress(success: @escaping (OPJobStatus) -> Void, failure: @escaping () -> Void) {
        let url = String(format:"%@/job", baseURL)

        getRequest(url: url, success: { [weak self] response in
            if let responseValue: OPJobStatus = self?.decodeObject(from: response) {
                success(responseValue)
            } else {
                failure()
            }
        }, failure: { _ in
                failure()
        })
    }

    public func getConnectionInformation(success: @escaping (OPConnectionInformation) -> Void,
                                         failure: @escaping () -> Void) {
        let url = String(format:"%@/connection",baseURL)
        getRequest(url: url, success: { [weak self] response in
            if let responseValue: OPConnectionInformation = self?.decodeObject(from: response) {
                success(responseValue)
            } else {
                failure()
            }
        }, failure: { _ in
            failure()
        })
    }

    public func getVersionNumber(success: @escaping (OPVersion) -> Void, failure: @escaping () -> Void) {
        let url = String(format:"%@/version",baseURL)
        getRequest(url: url, success: { [weak self] response in
            if let responseValue: OPVersion = self?.decodeObject(from: response) {
                success(responseValue)
            } else {
                failure()
            }
        }, failure: { _ in
                failure()
        })
    }

    public func getPrinterState(success: @escaping (OPPrinterState) -> Void, failure: @escaping () -> Void) {
        let url = String(format:"%@/printer",baseURL)
        getRequest(url: url, success: { [weak self] response in
            if let responseValue: OPPrinterState = self?.decodeObject(from: response) {
                success(responseValue)
            } else {
                failure()
            }
        }, failure: { _ in
                failure()
        })
    }

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

    private func getRequest(url: String, parameters: Parameters? = nil,
                            success: @escaping (Data?) -> Void, failure: @escaping (Data?) -> Void) {
        makeRequest(url: url, method: .get, parameters: parameters, success: success, failure: failure)
    }

    private func makeRequest(url: String, method: HTTPMethod, parameters: Parameters? = nil,
                             success: @escaping (Data?) -> Void, failure: @escaping (Data?) -> Void) {
        sessionManager.request(url, method: method, parameters: parameters, encoding: JSONEncoding.default,
                               headers: nil).validate().responseJSON { response in
            if response.result.isSuccess {
                success(response.data)
            } else {
                failure(response.data)
            }
        }
    }
}
