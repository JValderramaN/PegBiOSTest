//
//  ForecastTableViewCell.swift
//  PegBiOSTest
//
//  Created by José Valderrama on 23/03/2019.
//  Copyright © 2019 José Valderrama. All rights reserved.
//

import UIKit

class ForecastTableViewCell: UITableViewCell {
    
    static let identifier = "forecastCell"
    @IBOutlet private weak var temperatureLabel: UILabel!
    
    func setInfo(with forecast: Forecast) {
        switch forecast {
        case let dailyForecast as DailyForecast:
            temperatureLabel.text = "\(dailyForecast.temperatureRange?.min?.toText ?? "") ~ \(dailyForecast.temperatureRange?.max?.toText ?? "")"
        case let hourlyForecast as HourlyForecast:
            temperatureLabel.text = hourlyForecast.temperature?.toText
        default:
            break
        }
    }
    
}

extension Temperature {
    
    fileprivate var toText: String {
        guard let value = value, let unit = unit else { return "" }
        return "\(value) °\(unit)"
    }
    
}
