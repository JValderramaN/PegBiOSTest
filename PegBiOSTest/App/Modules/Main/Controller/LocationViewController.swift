//
//  RegionViewController.swift
//  PegBiOSTest
//
//  Created by José Valderrama on 21/03/2019.
//  Copyright © 2019 José Valderrama. All rights reserved.
//

import UIKit

class LocationViewController: UIViewController {
    
    static private let showForecasts = "showForecasts"
    
    @IBOutlet private weak var regionPicker: UIPickerView!
    @IBOutlet private weak var timePicker: UIPickerView!
    @IBOutlet private weak var searchForecastButton: UIBarButtonItem! {
        didSet {
            searchForecastButton.isEnabled = viewModel.hasForecastSearchInfo
        }
    }
    
    private let viewModel = LocationViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        viewModel.delegate = self
        viewModel.getCities()
    }
    
    @IBAction private func searchForecastButtonTapped(_ sender: Any) {
        viewModel.getForecastIfNeeded()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let forecastTableViewController = segue.destination as? ForecastTableViewController {
            forecastTableViewController.title = "\(viewModel.selectedCity?.localizedName ?? "") - \(viewModel.selectedTimeRange?.description ?? "")"
            forecastTableViewController.forecasts = viewModel.forecasts
        }
    }
    
}

extension LocationViewController: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView {
        case regionPicker:
            return viewModel.cities?.count ?? 0
        default:
            return viewModel.timeRanges.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView {
        case regionPicker:
            viewModel.selectedCity = viewModel.cities?[row]
        default:
            viewModel.selectedTimeRange = viewModel.timeRanges[row]
        }
    }

}

extension LocationViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView {
        case regionPicker:
            return viewModel.cities?[row].localizedName
        default:
            return viewModel.timeRanges[row].description
        }
    }
    
}

extension LocationViewController: LocationViewModelDelegate {
    
    func getForecastDidFinish(_ regionViewModel: LocationViewModel, with forecast: [Forecast]?, and error: Error?) {
        if let error = error {
            presentAlert(with: error)
            return
        }
        
        performSegue(withIdentifier: LocationViewController.showForecasts, sender: self)
    }
    

    func getCitiesDidFinish(_ regionViewModel: LocationViewModel, with cities: [City]?, and error: Error?) {
        if let error = error {
            presentAlert(with: error)
            return
        }
        
        regionPicker.reloadAllComponents()
    }
    
    func didUpdateForecastSearchInfo(_ regionViewModel: LocationViewModel, with forecastSearchInfo: ForecastSearchInfo?) {
        searchForecastButton.isEnabled = regionViewModel.hasForecastSearchInfo
    }
    
}
