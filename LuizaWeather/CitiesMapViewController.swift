//
//  CitiesMapViewController.swift
//  LuizaWeather
//
//  Created by Kako Botasso on 30/05/17.
//  Copyright © 2017 Kako Botasso. All rights reserved.
//

import UIKit
import MapKit

class CitiesMapViewController: UIViewController {
    
    // MARK: - Properties
    var cities : [City]?
    lazy var userLocation = UserLocation()
    var metric : Metric!
    var network : NetworkApi!
    
    // MARK: - Outlets
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var btnMetric: UIBarButtonItem!
    
    // MARK: Super methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureMapView()
        userLocation.requestLocation(viewController: self)
        setTimer()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        btnMetric.title = metric.changeMetricText()
        addCitiesToMap()
    }
    
    // MARK: - Methods
    func configureMapView(){
        mapView.mapType = .standard
        mapView.delegate = self
        mapView.showsUserLocation = true
    }
    
    func setTimer(){
        Timer.scheduledTimer(timeInterval: 60, target: self, selector: #selector(self.addCitiesToMap), userInfo: nil, repeats: true)
    }
    
    func addCitiesToMap(){
        removePinCities()
        
        for city in cities! {
            guard let cityCoordinates = city.coordinates else { return }
            var actualTemp : Double!
            
            if let tempeture = city.main {
                actualTemp = tempeture.actual!
            }
            
            
            let coordinate = CLLocationCoordinate2D(latitude: cityCoordinates.lat!, longitude: cityCoordinates.long!)
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            annotation.title = "\(city.name!) - \(Int(actualTemp!))\(metric.getMetricText())"
            mapView.addAnnotation(annotation)
        }
    }
    
    func removePinCities(){
        let allAnotations = mapView.annotations
        mapView.removeAnnotations(allAnotations)
    }

    // MARK: - Actions
    @IBAction func changeMetric(_ sender: Any) {
        metric.changeMetric()
        
        let api = RequestApi.init(network: network)
        api.requestCities(metric: metric) { response in
            self.cities = response
            self.addCitiesToMap()
            self.btnMetric.title = self.metric.changeMetricText()
        }
    }
}

// MARK: - MKMapViewDelegate
extension CitiesMapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        var annotationView: MKAnnotationView!
        
        if annotation is MKPinAnnotationView {
            annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "CityPin") as! MKPinAnnotationView
            
            if annotationView == nil{
                annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "CityPin")
                annotationView.canShowCallout = true
                (annotationView as! MKPinAnnotationView).animatesDrop = true
            }else{
                annotationView.annotation = annotation
            }
        }
        
        return annotationView
    }
    
}

// MARK: - CLLocationManagerDelegate
extension CitiesMapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            print("Acabou de autorizar")
            userLocation.monitorUserLocation()
        default:
            break
        }
        
    }
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        let region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 50000, 50000)
        mapView.setRegion(region, animated: true)
        
        network = NetworkApi.init(userLocation.coordinate.latitude, userLocation.coordinate.longitude)
        print("Coordenadas Mapa: \(userLocation.coordinate.latitude)  \(userLocation.coordinate.longitude)")
    }
}
