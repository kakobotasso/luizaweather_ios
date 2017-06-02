//
//  Coordinates.swift
//  LuizaWeather
//
//  Created by Kako Botasso on 28/05/17.
//  Copyright © 2017 Kako Botasso. All rights reserved.
//

import Foundation
import ObjectMapper

class Coordinates : Mappable {
    
    // MARK: - Properties
    var lat: Double?
    var long: Double?
    
    // MARK: - Initializers
    required init?(map: Map){}
    
    // MARK: - Methods
    func mapping(map: Map){
        lat <- map["lat"]
        long <- map["lon"]
    }
}
