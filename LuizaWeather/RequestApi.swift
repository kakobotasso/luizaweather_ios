//
//  RequestApi.swift
//  LuizaWeather
//
//  Created by Kako Botasso on 01/06/17.
//  Copyright © 2017 Kako Botasso. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

class RequestApi {
    var network: NetworkApi!
    var cities : [City] = []
    
    init(network: NetworkApi) {
        self.network = network
    }
    
    func requestCities(metric: Metric, completionHandler : @escaping ([City]) -> Void){
        guard network != nil else { return }
        
        if metric.getMetric() {
            network.urlWith(units: "metric")
        } else {
            network.urlWith(units: "imperial")
        }
        
        Alamofire.request(network.url!).responseObject { (response: DataResponse<WeatherApiResponse>) in
            let weatherApiResponse = response.result.value
            
            
            guard let apiResponse = weatherApiResponse else{
                return
            }
            
            if let citiesList = apiResponse.list {
                completionHandler(citiesList)
            }
        }
    }
    
}
