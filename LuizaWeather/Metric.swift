//
//  Metric.swift
//  LuizaWeather
//
//  Created by Kako Botasso on 01/06/17.
//  Copyright © 2017 Kako Botasso. All rights reserved.
//

import Foundation

class Metric {
    var metricCelsius: Bool!
    let KEY = "metric"
    
    init() {
        metricCelsius = true
        setDefaultMetric(metricCelsius)
    }
    
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
