//
//  ServerError.swift
//  PegBiOSTest
//
//  Created by José Valderrama on 23/03/2019.
//  Copyright © 2019 José Valderrama. All rights reserved.
//

import Foundation
import ObjectMapper

struct ServerError: Mappable, CustomStringConvertible, LocalizedError {

    var code: String?
    var message: String?
    
    var description: String {
        return """
        code:\(code ?? "")
        message:\(message ?? "")
        """
    }
    
    var errorDescription: String? {
        return "\(code ?? "") - \(message ?? "")"
    }
    
    var isValid: Bool {
        return code != nil && message != nil
    }
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        code <- map["Code"]
        message <- map["Message"]
    }
    
}
