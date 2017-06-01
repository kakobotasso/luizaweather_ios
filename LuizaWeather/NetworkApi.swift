//
//  NetworkApi.swift
//  LuizaWeather
//
//  Created by Kako Botasso on 30/05/17.
//  Copyright © 2017 Kako Botasso. All rights reserved.
//

import Foundation

class NetworkApi {
    let API_KEY = "4cfaeda48113347d82b8692ae766e1f3"
    var url: String!
    var lat: Double!
    var long: Double!
    
    init(lat: Double, long: Double) {
        self.lat = lat
        self.long = long
        resetUrl()
    }
    
    func urlWith(units: String){
        resetUrl()
        url = "\(url!)&units=\(units)"
    }
    
    func resetUrl(){
        url = "http://api.openweathermap.org/data/2.5/find?APPID=\(API_KEY)&lat=\(lat!)&lon=\(long!)&cnt=50&lang=pt"
    }
}
