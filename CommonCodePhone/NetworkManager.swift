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
    
    public func getVersionNumber() {
        let url = String(format:"%@/version",baseURL)
        
        sessionManager.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).validate().responseJSON { response in
            print(String(data:response.data!,encoding:.utf8)!)
        }
    }
}
