//
//  Tempeture.swift
//  LuizaWeather
//
//  Created by Kako Botasso on 29/05/17.
//  Copyright © 2017 Kako Botasso. All rights reserved.
//

import Foundation

class Tempeture {
    var actual: Double!
    var pressure: Int!
    var humidity: Int!
    var min: Int!
    var max: Int!
    
    init(actual: Double, pressure: Int, humidity: Int, min: Int, max: Int) {
        self.actual = actual
        self.pressure = pressure
        self.humidity = humidity
        self.min = min
        self.max = max
    }
}
