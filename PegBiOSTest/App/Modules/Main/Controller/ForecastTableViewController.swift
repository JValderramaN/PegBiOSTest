//
//  ForecastTableViewController.swift
//  PegBiOSTest
//
//  Created by José Valderrama on 23/03/2019.
//  Copyright © 2019 José Valderrama. All rights reserved.
//

import UIKit

class ForecastTableViewController: UITableViewController {
    
    var forecasts: [Forecast]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecasts?.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ForecastTableViewCell.identifier, for: indexPath) as? ForecastTableViewCell,
         let forecast = forecasts?[indexPath.row] else {
            return UITableViewCell()
        }

        cell.setInfo(with: forecast)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let forecastLink = forecasts?[indexPath.row].link,
        let url = URL(string: forecastLink) else { return }
        
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:])
        } else {
            UIApplication.shared.openURL(url)
        }        
    }
 
}
