//
//  City.swift
//  PegBiOSTest
//
//  Created by José Valderrama on 21/03/2019.
//  Copyright © 2019 José Valderrama. All rights reserved.
//

import Foundation
import ObjectMapper

struct City: Mappable, CustomStringConvertible {
    
    var key: String?
    var localizedName: String?
    
    var description: String {
        return """
        key:\(key ?? "")
        localizedName:\(localizedName ?? "")
        """
    }
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        key <- map["Key"]
        localizedName <- map["LocalizedName"]
    }
    
}
