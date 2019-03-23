//
//  LocationViewModel.swift
//  PegBiOSTest
//
//  Created by José Valderrama on 21/03/2019.
//  Copyright © 2019 José Valderrama. All rights reserved.
//

import Foundation
import Moya
import ObjectMapper
import SVProgressHUD

protocol LocationViewModelDelegate: AnyObject {
    func getCitiesDidFinish(_ regionViewModel: LocationViewModel, with cities: [City]?, and error: Error?)
    func didUpdateForecastSearchInfo(_ regionViewModel: LocationViewModel, with forecastSearchInfo: ForecastSearchInfo?)
    func getForecastDidFinish(_ regionViewModel: LocationViewModel, with forecast: [Forecast]?, and error: Error?)
}

class LocationViewModel: NSObject {
    
    weak var delegate: LocationViewModelDelegate?
    
    public private(set) var cities: [City]?
    var selectedCity: City? {
        didSet {
            delegate?.didUpdateForecastSearchInfo(self, with: forecastSearchInfo)
        }
    }
    
    var timeRanges: [TimeRange]  { return TimeRange.allCases }
    var selectedTimeRange: TimeRange? {
        didSet {
            delegate?.didUpdateForecastSearchInfo(self, with: forecastSearchInfo)
        }
    }
    
    public private(set) var forecasts: [Forecast]?
    
    var forecastSearchInfo: ForecastSearchInfo? {
        guard let selectedTimeRange = selectedTimeRange, let selectedCityKey = selectedCity?.key else {
            return nil
        }
        
        return ForecastSearchInfo(timeRange: selectedTimeRange, locationKey: selectedCityKey)
    }
    
    var hasForecastSearchInfo: Bool {
        return forecastSearchInfo != nil
    }
    
    func getCities() {
        SVProgressHUD.show()
        NetworkServiceManager.shared.provider.request(.topCities(category: .high)) { [weak self] (result) in
            SVProgressHUD.dismiss()
            guard let strongSelf = self else { return }
            
            switch result {
            case let .success(moyaResponse):
                do {
                    let response = try moyaResponse.mapString()
                    
                    if let error = ServerError(JSONString: response), error.isValid {
                        strongSelf.delegate?.getForecastDidFinish(strongSelf, with: nil, and: error)
                        return
                    }
                    
                    let cities = Mapper<City>().mapArray(JSONString: response)
                    strongSelf.cities = cities
                    strongSelf.delegate?.getCitiesDidFinish(strongSelf, with: cities, and: nil)
                } catch let error {
                    strongSelf.delegate?.getCitiesDidFinish(strongSelf, with: nil, and: error)
                }
            case let .failure(error):
                strongSelf.delegate?.getCitiesDidFinish(strongSelf, with: nil, and: error)
            }
        }
    }
    
    func getForecastIfNeeded() {
        guard let forecastSearchInfo = forecastSearchInfo else { return }
        
        SVProgressHUD.show()
        NetworkServiceManager.shared.provider.request(.forecast(searchInfo: forecastSearchInfo)) { [weak self] (result) in
            SVProgressHUD.dismiss()
            guard let strongSelf = self else { return }
            
            switch result {
            case let .success(moyaResponse):
                do {
                    let responseString = try moyaResponse.mapString()
                    let responseJSON = try moyaResponse.mapJSON() as? NSDictionary
                    
                    if let error = ServerError(JSONString: responseString), error.isValid {
                        strongSelf.delegate?.getForecastDidFinish(strongSelf, with: nil, and: error)
                        return
                    }
                    
                    let forecasts: [Forecast]? =
                        forecastSearchInfo.timeRange.isHourly ?
                            Mapper<HourlyForecast>().mapArray(JSONString: responseString) :
                            Mapper<DailyForecast>().mapArray(JSONObject: responseJSON?["DailyForecasts"])

                    strongSelf.forecasts = forecasts
                    strongSelf.delegate?.getForecastDidFinish(strongSelf, with: forecasts, and: nil)
                } catch let error {
                    strongSelf.delegate?.getForecastDidFinish(strongSelf, with: nil, and: error)
                }
            case let .failure(error):
                strongSelf.delegate?.getForecastDidFinish(strongSelf, with: nil, and: error)
            }
        }
    }
}

