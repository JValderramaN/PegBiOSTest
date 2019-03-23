//
//  Temperature.swift
//  PegBiOSTest
//
//  Created by José Valderrama on 23/03/2019.
//  Copyright © 2019 José Valderrama. All rights reserved.
//

import Foundation
import ObjectMapper

struct TemperatureRange: Mappable, CustomStringConvertible {
    
    var min: Temperature?
    var max: Temperature?
    
    var description: String {
        return """
        min:\(min?.description ?? "")
        max:\(max?.description ?? "")
        """
    }
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        min <- map["Minimum"]
        max <- map["Maximum"]
    }
    
}

struct Temperature: Mappable, CustomStringConvertible {
    
    var value: Double?
    var unit: String?
    
    var description: String {
        return """
        value:\(value ?? 0)
        unit:\(unit ?? "")
        """
    }
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        value <- map["Value"]
        unit <- map["Unit"]
    }
    
}
