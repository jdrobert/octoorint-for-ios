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
    private let baseURL = "http://octopi.local/api"
    
    init() {
        let config = URLSessionConfiguration.default
        config.httpAdditionalHeaders = ["X-Api-Key":"772B1B4E41FC41AD8962698BE5D6925D"]
        sessionManager = Alamofire.SessionManager(configuration: config)
    }
    
    public func getVersionNumber(success: @escaping (OctoPrintVersion) -> Void, failure: @escaping () -> Void) {
        let url = String(format:"%@/version",baseURL)
        getRequest(url: url, success: { response in
            do {
                if let responseValue = response {
                    let decoder = JSONDecoder()
                    let version = try decoder.decode(OctoPrintVersion.self, from: responseValue)
                    success(version)
                }
            } catch {
                failure()
            }
        }) { response in
            failure()
        }
    }
    
    private func getRequest(url: String, parameters: Parameters? = nil, success: @escaping (Data?) -> Void, failure: @escaping (Data?) -> Void) {
        makeRequest(url: url, method: .get, parameters: parameters, success: success, failure: failure)
    }
    
    private func makeRequest(url: String, method: HTTPMethod, parameters: Parameters? = nil, success: @escaping (Data?) -> Void, failure: @escaping (Data?) -> Void) {
        sessionManager.request(url, method: method, parameters: parameters, encoding: JSONEncoding.default, headers: nil).validate().responseJSON { response in
            if response.result.isSuccess {
                success(response.data)
            } else {
                failure(response.data)
            }
        }
    }
}
