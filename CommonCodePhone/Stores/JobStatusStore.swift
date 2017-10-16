//
//  JobStatusStore.swift
//  OctoPrint
//
//  Created by Jeremy Roberts on 10/16/17.
//  Copyright © 2017 Quiver Apps. All rights reserved.
//

import Foundation

public class JobStatusStore {
    
    private let jobStatusKey = "jobStatus"
    private let hasErrorKey = "hasError"
    
    public init() {
        
    }
    
    public var jobStatus: OPJobStatus? {
        get {
            let decoder = JSONDecoder()
            if let data = UserDefaults.standard.data(forKey: jobStatusKey), let status = try? decoder.decode(OPJobStatus.self, from: data) {
                return status
            }
            
            return nil
        }
        set {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(newValue) {
                UserDefaults.standard.set(encoded, forKey: jobStatusKey)
            }
        }
    }
    
    public var hasError: Bool {
        get {
            return UserDefaults.standard.bool(forKey: hasErrorKey)
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: hasErrorKey)
        }
    }
}
