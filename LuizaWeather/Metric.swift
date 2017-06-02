//
//  Metric.swift
//  LuizaWeather
//
//  Created by Kako Botasso on 01/06/17.
//  Copyright © 2017 Kako Botasso. All rights reserved.
//

import Foundation

class Metric {
    
    // MARK: - Properties
    var metricCelsius: Bool!
    let KEY = "metric"
    
    // MARK: - Initializers
    init() {
        metricCelsius = true
        setDefaultMetric(metricCelsius)
    }
    
    // MARK: - Methods
    func changeMetric(){
        if metricCelsius {
            metricCelsius = false
        } else {
            metricCelsius = true
        }
        setDefaultMetric(metricCelsius)
    }
    
    func changeMetricText() -> String {
        if metricCelsius {
            return "°F"
        } else {
            return "°C"
        }
    }
    
    func getMetricText() -> String {
        if metricCelsius {
            return "°C"
        }
        return "°F"
    }
    
    func getMetric() -> Bool{
        return metricCelsius
    }
    
    private func setDefaultMetric(_ metric: Bool){
        UserDefaults.standard.set(metric, forKey: KEY)
    }
    
}
