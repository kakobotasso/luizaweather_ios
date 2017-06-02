//
//  UserLocation.swift
//  LuizaWeather
//
//  Created by Kako Botasso on 02/06/17.
//  Copyright © 2017 Kako Botasso. All rights reserved.
//

import UIKit
import CoreLocation

class UserLocation {
    // MARK: - Properties
    var locationManager : CLLocationManager!
    
    // MARK: - Initilizers
    init() {
        locationManager = CLLocationManager()
    }
    
    // MARK: - Methods
    func requestLocation(viewController: UIViewController){
        if CLLocationManager.locationServicesEnabled(){
            if viewController is CitiesTableViewController{
                locationManager.delegate = viewController as! CitiesTableViewController
            } else {
                locationManager.delegate = viewController as! CitiesMapViewController
            }
            
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
    
    func stopMonitorUserLocation(){
        locationManager.stopUpdatingLocation()
    }
    
}
