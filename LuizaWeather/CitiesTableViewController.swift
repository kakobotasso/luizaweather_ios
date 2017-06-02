//
//  CitiesTableViewController.swift
//  LuizaWeather
//
//  Created by Kako Botasso on 28/05/17.
//  Copyright © 2017 Kako Botasso. All rights reserved.
//

import UIKit
import CoreLocation

class CitiesTableViewController: UITableViewController {

    // MARK: - Properties
    var cities: [City] = []
    var arrayResponse = [[String: AnyObject]]()
    var network: NetworkApi!
    var metric = Metric()
    lazy var userLocation = UserLocation()
    
    // MARK: - Outlets
    @IBOutlet weak var btnMetric: UIBarButtonItem!
    
    // MARK: - Super methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userLocation.requestLocation(viewController: self)
        setTimer()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        btnMetric.title = metric.changeMetricText()
        userLocation.requestLocation(viewController: self)
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
        
        cell.drawCity(city: city, metric: metric)
        return cell
    }
    
    // MARK: - Methods
    func setTimer(){
        Timer.scheduledTimer(timeInterval: 60, target: self, selector: #selector(self.monitorUser), userInfo: nil, repeats: true)
    }
    
    func monitorUser(){
        userLocation.monitorUserLocation()
    }
    
    func requestCities(){
        let api = RequestApi.init(network: network)
        api.requestCities(metric: metric) { response in
            self.cities = response
            self.sendObjectsToMap()
            self.tableView.reloadData()
        }
    }
    
    func sendObjectsToMap(){
        let nc = self.tabBarController?.viewControllers?[1] as! UINavigationController
        if nc.topViewController is CitiesMapViewController {
            let mapVc = nc.topViewController as! CitiesMapViewController
            mapVc.cities = cities
            mapVc.metric = metric
        }
    }
    
    // MARK: - Actions
    @IBAction func changeMetric(_ sender: Any) {
        metric.changeMetric()
        btnMetric.title = metric.changeMetricText()
        requestCities()
    }
}

// MARK: - CLLocationManagerDelegate
extension CitiesTableViewController : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            print("Acabou de autorizar")
            userLocation.monitorUserLocation()
        default:
            break
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let coordinates : CLLocationCoordinate2D = manager.location!.coordinate
        
        network = NetworkApi.init(coordinates.latitude, coordinates.longitude)
        userLocation.stopMonitorUserLocation()
        requestCities()
        
        print("Coordenadas: \(coordinates.latitude) | \(coordinates.longitude)")
    }
}
