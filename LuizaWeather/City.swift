//
//  City.swift
//  LuizaWeather
//
//  Created by Kako Botasso on 28/05/17.
//  Copyright © 2017 Kako Botasso. All rights reserved.
//

import Foundation
import ObjectMapper

class City : Mappable {
    var id: Int?
    var name: String?
    var coordinates: Coordinates?
    var main: Tempeture?
    var weather: [Weather]?
    
    required init?(map: Map) {}
    
    func mapping(map: Map){
        id <- map["map"]
        name <- map["name"]
        coordinates <- map["coord"]
        main <- map["main"]
        weather <- map["weather"]
    }
}
