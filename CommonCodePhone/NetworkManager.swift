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
    
    public func getJobProgress(success: @escaping (OPJobStatus) -> Void, failure: @escaping () -> Void) {
        let url = String(format:"%@/job", baseURL)
        
        getRequest(url: url, success: { [weak self] response in
            if let responseValue: OPJobStatus = self?.decodeObject(from: response) {
                success(responseValue)
            } else {
                failure()
            }
        }) { response in
            failure()
        }
    }
    
    public func getConnectionInformation(success: @escaping (OPConnectionInformation) -> Void, failure: @escaping () -> Void) {
        let url = String(format:"%@/connection",baseURL)
        getRequest(url: url, success: { [weak self] response in
            if let responseValue: OPConnectionInformation = self?.decodeObject(from: response) {
                success(responseValue)
            } else {
                failure()
            }
        }) { response in
            failure()
        }
    }
    
    public func getVersionNumber(success: @escaping (OPVersion) -> Void, failure: @escaping () -> Void) {
        let url = String(format:"%@/version",baseURL)
        getRequest(url: url, success: { [weak self] response in
            if let responseValue: OPVersion = self?.decodeObject(from: response) {
                success(responseValue)
            } else {
                failure()
            }
        }) { response in
            failure()
        }
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
