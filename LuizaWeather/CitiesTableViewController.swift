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
import CoreLocation

class CitiesTableViewController: UITableViewController {

    // MARK: - Properties
    var cities: [City] = []
    var arrayResponse = [[String: AnyObject]]()
    var network: NetworkApi!
    lazy var locationManager = CLLocationManager()
    
    // MARK: - Super Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        requestLocation()
        Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(self.monitorUserLocation), userInfo: nil, repeats: true)
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cities.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CityTableViewCell
        let city = cities[indexPath.row]
        
        cell.drawCity(city: city)
        return cell
    }
    
    // MARK: - Methods
    func requestLocation(){
        if CLLocationManager.locationServicesEnabled(){
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            
            switch CLLocationManager.authorizationStatus() {
            case .authorizedWhenInUse, .authorizedAlways:
                print("Usuário já autorizou!")
                monitorUserLocation()
            case .notDetermined:
                print("Usuário ainda não autorizou!")
                locationManager.requestWhenInUseAuthorization()
            case .denied:
                print("Usuário não autorizou!")
            case .restricted:
                print("O acesso ao GPS está bloqueado")
            }
        }
    }
    
    func monitorUserLocation(){
        locationManager.startUpdatingLocation()
    }
    
    func requestCities(){
        guard network != nil else {
            return
        }
        
        Alamofire.request(network.url).responseObject { (response: DataResponse<WeatherApiResponse>) in
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
}

// MARK: - CLLocationManagerDelegate
extension CitiesTableViewController : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            print("Acabou de autorizar")
            monitorUserLocation()
        default:
            break
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let coordinates : CLLocationCoordinate2D = manager.location!.coordinate
        self.network = NetworkApi.init(lat: coordinates.latitude, long: coordinates.longitude)
        locationManager.stopUpdatingLocation()
        requestCities()
    }
}
