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
    lazy var locationManager = CLLocationManager()
    
    // MARK: - Outlets
    @IBOutlet weak var btnMetric: UIBarButtonItem!
    
    // MARK: - Super methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        requestLocation()
        Timer.scheduledTimer(timeInterval: 60, target: self, selector: #selector(self.monitorUserLocation), userInfo: nil, repeats: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        btnMetric.title = metric.changeMetricText()
        requestLocation()
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
            monitorUserLocation()
        default:
            break
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let coordinates : CLLocationCoordinate2D = manager.location!.coordinate
        network = NetworkApi.init(coordinates.latitude, coordinates.longitude)
        locationManager.stopUpdatingLocation()
        requestCities()
        print("Coordenadas: \(coordinates.latitude) | \(coordinates.longitude)")
    }
}
