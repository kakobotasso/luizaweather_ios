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
    lazy var locationManager = CLLocationManager()
    var metric : Metric!
    var network : NetworkApi!
    
    // MARK: - Outlets
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var btnMetric: UIBarButtonItem!
    
    // MARK: Super methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.mapType = .standard
        mapView.delegate = self
        mapView.showsUserLocation = true
        
        requestLocation()
        Timer.scheduledTimer(timeInterval: 60, target: self, selector: #selector(self.addCitiesToMap), userInfo: nil, repeats: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        btnMetric.title = metric.changeMetricText()
        addCitiesToMap()
    }
    
    // MARK: - Methods
    func requestLocation() {
        // Verifica se é possivel trabalhar com servicos de localização
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
    
    func monitorUserLocation(){
        locationManager.startUpdatingLocation()
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

// MARK: MKMapViewDelegate
extension CitiesMapViewController: MKMapViewDelegate {
    
    // É chamado sempre que uma annotation (pin) for exibida
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        var annotationView: MKAnnotationView!
        
        if annotation is MKPinAnnotationView {
            // Aqui ele reutiliza pins já criados
            annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "CityPin") as! MKPinAnnotationView
            
            if annotationView == nil{
                annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "CityPin")
                annotationView.canShowCallout = true // Exibe o title e o subtitle
                (annotationView as! MKPinAnnotationView).pinTintColor = .blue // Muda cor
                (annotationView as! MKPinAnnotationView).animatesDrop = true // Faz animacao de cair o pin na tela
            }else{
                annotationView.annotation = annotation
            }
        }
        
        return annotationView
    }
    
}

// MARK: CLLocationManagerDelegate
extension CitiesMapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            print("Acabou de autorizar")
            monitorUserLocation()
        default:
            break
        }
        
    }
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        let region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 50000, 50000)
        mapView.setRegion(region, animated: true)
        
        network = NetworkApi.init(userLocation.coordinate.latitude, userLocation.coordinate.longitude)
        print("coiso")
    }
}
