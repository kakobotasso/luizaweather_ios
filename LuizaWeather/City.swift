//
//  City.swift
//  LuizaWeather
//
//  Created by Kako Botasso on 28/05/17.
//  Copyright © 2017 Kako Botasso. All rights reserved.
//

import Foundation

class City {
    var id: Int!
    var name: String!
    var coordinates: Coordinates!
    var main: Tempeture!
    var weather: Weather!
    
    init(id: Int, name: String){
        self.id = id
        self.name = name
    }
}
