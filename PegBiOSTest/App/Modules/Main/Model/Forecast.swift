//
//  Forecast.swift
//  PegBiOSTest
//
//  Created by José Valderrama on 23/03/2019.
//  Copyright © 2019 José Valderrama. All rights reserved.
//

import Foundation
import ObjectMapper

struct ForecastSearchInfo {
    let timeRange: TimeRange
    let locationKey: String
}

class DailyForecast: Forecast {
    
    var temperatureRange: TemperatureRange?
    
    override var description: String {
        return """
        \(super.description)
        temperatureRange: \(temperatureRange?.description ?? "")
        """
    }
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        temperatureRange <- map["Temperature"]
    }
    
}

class HourlyForecast: Forecast {
    
    var temperature: Temperature?
    
    override var description: String {
        return """
        \(super.description)
        temperature: \(temperature?.description ?? "")
        """
    }
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        temperature <- map["Temperature"]
    }
    
}

class Forecast: Mappable, CustomStringConvertible {
    
    var link: String?
    
    var description: String {
        return """
        link:\(link ?? "")
        """
    }
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        link  <- map["Link"]
    }
    
}
