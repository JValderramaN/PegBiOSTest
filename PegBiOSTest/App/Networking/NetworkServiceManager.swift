//
//  NetworkServiceManager.swift
//  PegBiOSTest
//
//  Created by José Valderrama on 21/03/2019.
//  Copyright © 2019 José Valderrama. All rights reserved.
//

import Foundation
import Moya

class NetworkServiceManager {
    var sessionCookie: String?
    let provider = MoyaProvider<APIServices>()
    
    static let shared = NetworkServiceManager()
    
    fileprivate init() {}
    
    func restartData() {
        sessionCookie = nil
    }
}
