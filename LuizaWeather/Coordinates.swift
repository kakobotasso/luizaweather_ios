//
//  Coordinates.swift
//  LuizaWeather
//
//  Created by Kako Botasso on 28/05/17.
//  Copyright © 2017 Kako Botasso. All rights reserved.
//

import Foundation
import SwiftyJSON

class Coordinates {
    var lat: Double!
    var long: Double!
    
    init(params: AnyObject) {
//        for (key, subJson) in params {
//            print(subJson["lat"])
//        }
        
    }
    
    init(lat: Double, long: Double) {
        self.lat = lat
        self.long = long
    }
}
