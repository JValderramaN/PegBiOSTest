//
//  APIServices.swift
//  PegBiOSTest
//
//  Created by José Valderrama on 21/03/2019.
//  Copyright © 2019 José Valderrama. All rights reserved.
//

import Foundation
import Moya

enum APIParams: String {
    case apiKey = "apikey"
    case locationKey = "locationKey"
}

enum TopCitiesCategory: String {
    case high = "50"
    case medium = "100"
    case low = "150"
}

enum TimeRange: String, CustomStringConvertible, CaseIterable {
    case in1Hour = "hourly/1hour"
    case in12Hour = "hourly/12hour"
    case in1Day = "daily/1day"
    case in5Day = "daily/5day"
    
    var description: String {
        switch self {
        case .in1Hour:
            return "1 Hour"
        case .in12Hour:
            return "12 Hours"
        case .in1Day:
            return "1 Day"
        case .in5Day:
            return "5 Days"
        }
    }
    
    var isHourly: Bool {
        switch self {
        case .in1Hour, .in12Hour:
            return true
        default:
            return false
        }
    }
    
}

// MARK: - Base API Services

enum APIServices {
    case topCities(category: TopCitiesCategory)
    case forecast(searchInfo: ForecastSearchInfo)
}

// MARK: - TargetType Protocol Implementation

extension APIServices: TargetType {
    
    var apiKey: String {
        return "v7jgjZXfAy8nyA9bSRcGe4RtQEU0UoSA"
    }
    
    var baseURL: URL {
        return URL(string: "http://dataservice.accuweather.com/")!
    }
    
    var path: String {
        switch self {
        case .topCities(let category):
            return "locations/v1/topcities/\(category.rawValue)"
        case .forecast(let searchInfo):
            return "forecasts/v1/\(searchInfo.timeRange.rawValue)/\(searchInfo.locationKey)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .topCities:
            return .get
        case .forecast:
            return .get
        }
    }
    
    var sampleData: Data {
        switch self {
        case .topCities:
            return "".utf8Encoded
        case .forecast:
            return "".utf8Encoded
        }
    }
    
    var task: Task {
        return .requestParameters(parameters: [APIParams.apiKey.rawValue : apiKey], encoding: URLEncoding.queryString)
    }
    
    var headers: [String : String]? {
        return ["Content-type": "text/html;charset=UTF-8"]
    }
    
}

// MARK: - Helpers
private extension String {
    
    var urlEscaped: String {
        return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
    
    var utf8Encoded: Data {
        return data(using: .utf8)!
    }
    
}
