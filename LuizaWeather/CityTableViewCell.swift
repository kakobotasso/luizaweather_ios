//
//  CityTableViewCell.swift
//  LuizaWeather
//
//  Created by Kako Botasso on 31/05/17.
//  Copyright © 2017 Kako Botasso. All rights reserved.
//

import UIKit

class CityTableViewCell: UITableViewCell {

    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var ivClimate: UIImageView!
    @IBOutlet weak var lblClimate: UILabel!
    @IBOutlet weak var lblActualTemp: UILabel!
    @IBOutlet weak var lblMinTemp: UILabel!
    @IBOutlet weak var lblMaxTemp: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func drawCity(city: City, metricCelsius: Bool){
        var metric: String!
        
        if metricCelsius {
            metric = "°C"
        } else{
            metric = "°F"
        }
        
        if let name = city.name {
            lblName.text = name
        }
        
        if let main = city.main {
            
            if let actual = main.actual {
                lblActualTemp.text = "\(Int(actual))\(metric!)"
            }
            
            if let min = main.min {
                lblMinTemp.text = "\(Int(min))\(metric!)"
            }
            
            if let max = main.max {
                lblMaxTemp.text = "\(Int(max))\(metric!)"
            }
            
        }
        
        if let weatherList = city.weather {
            let weather = weatherList.first!
            
            if let description = weather.description {
                lblClimate.text = description
            }
            
            if let iconName = weather.icon {
                ivClimate.image = UIImage(named: iconName)
            }
            
        }
        
    }

}
