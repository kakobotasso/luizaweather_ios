//
//  WeatherApiResponse.swift
//  LuizaWeather
//
//  Created by Kako Botasso on 30/05/17.
//  Copyright © 2017 Kako Botasso. All rights reserved.
//

import Foundation
import ObjectMapper

class WeatherApiResponse : Mappable {
    
    // MARK: - Properties
    var message: String?
    var cod: String?
    var count: Int?
    var list: [City]?

    // MARK: - Initializers
    required init?(map: Map) {}
    
    // MARK: - Methods
    func mapping(map: Map){
        message <- map["message"]
        cod <- map["cod"]
        count <- map["count"]
        list <- map["list"]
    }
    
}
