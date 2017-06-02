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
    
    // MARK: - Properties
    var id: Int?
    var main: String?
    var description: String?
    var icon: String?
    
    // MARK: - Initializers
    required init?(map: Map) {}
    
    // MARK: - Methods
    func mapping(map: Map){
        id <- map["id"]
        main <- map["main"]
        description <- map["description"]
        icon <- map["icon"]
    }
}
