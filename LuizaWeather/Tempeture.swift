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
    
    // MARK: - Properties
    var actual: Double?
    var pressure: Int?
    var humidity: Int?
    var min: Double?
    var max: Double?
    
    // MARK: - Initializers
    required init?(map: Map) {}
    
    // MARK: - Methods
    func mapping(map: Map){
        actual <- map["temp"]
        pressure <- map["pressure"]
        humidity <- map["humidity"]
        min <- map["temp_min"]
        max <- map["temp_min"]
    }
}
