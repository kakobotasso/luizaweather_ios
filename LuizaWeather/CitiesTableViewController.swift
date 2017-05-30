//
//  CitiesTableViewController.swift
//  LuizaWeather
//
//  Created by Kako Botasso on 28/05/17.
//  Copyright © 2017 Kako Botasso. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper

class CitiesTableViewController: UITableViewController {

    let API_KEY = "4cfaeda48113347d82b8692ae766e1f3"
    
    let url = "http://api.openweathermap.org/data/2.5/find?lat=-23.5613068&lon=-46.60373&units=metric&cnt=50&lang=pt&APPID=4cfaeda48113347d82b8692ae766e1f3"
    
    var cities: [City] = []
    var arrayResponse = [[String: AnyObject]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Alamofire.request(url).responseObject { (response: DataResponse<WeatherApiResponse>) in
            let weatherApiResponse = response.result.value
            
            guard let apiResponse = weatherApiResponse else{
                return
            }
            
            if let citiesList = apiResponse.list {
                self.cities = citiesList
                self.tableView.reloadData()
            }
            
        }
        
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cities.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        let city = cities[indexPath.row]
        cell.textLabel!.text = city.name!

        return cell
    }
}
