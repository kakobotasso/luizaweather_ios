//
//  Tempeture.swift
//  LuizaWeather
//
//  Created by Kako Botasso on 29/05/17.
//  Copyright © 2017 Kako Botasso. All rights reserved.
//

import Foundation
import ObjectMapper

class Tempeture : Mappable {
    var actual: Double?
    var pressure: Int?
    var humidity: Int?
    var min: Double?
    var max: Double?
    
    required init?(map: Map) {}
    
    func mapping(map: Map){
        actual <- map["temp"]
        pressure <- map["pressure"]
        humidity <- map["humidity"]
        min <- map["temp_min"]
        max <- map["temp_min"]
    }
}
