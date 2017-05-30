//
//  Weather.swift
//  LuizaWeather
//
//  Created by Kako Botasso on 28/05/17.
//  Copyright © 2017 Kako Botasso. All rights reserved.
//

import Foundation
import ObjectMapper

class Weather : Mappable{
    var id: Int?
    var main: String?
    var description: String?
    var icon: String?
    
    required init?(map: Map) {}
    
    func mapping(map: Map){
        id <- map["id"]
        main <- map["main"]
        description <- map["description"]
        icon <- map["icon"]
    }
}
