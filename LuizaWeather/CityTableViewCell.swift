//
//  CityTableViewCell.swift
//  LuizaWeather
//
//  Created by Kako Botasso on 31/05/17.
//  Copyright © 2017 Kako Botasso. All rights reserved.
//

import UIKit

class CityTableViewCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var ivClimate: UIImageView!
    @IBOutlet weak var lblClimate: UILabel!
    @IBOutlet weak var lblActualTemp: UILabel!
    @IBOutlet weak var lblMinTemp: UILabel!
    @IBOutlet weak var lblMaxTemp: UILabel!
    
    // MARK: - Properties
    var city : City!
    var metricText : String!
    
    // MARK: - Super methods
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - Methods
    func drawCity(city: City, metric: Metric){
        self.city = city
        self.metricText = metric.getMetricText()
        
        drawName()
        drawTempetures()
        drawWeather()
    }
    
    private func drawName(){
        if let name = city.name {
            lblName.text = name
        }
    }
    
    private func drawTempetures(){
        guard let tempeture = city.main else { return }
        
        if let actual = tempeture.actual {
            lblActualTemp.text = "\(Int(actual))\(metricText!)"
        }
        
        if let min = tempeture.min {
            lblMinTemp.text = "\(Int(min))\(metricText!)"
        }
        
        if let max = tempeture.max {
            lblMaxTemp.text = "\(Int(max))\(metricText!)"
        }
    }
    
    private func drawWeather(){
        guard let weatherList = city.weather else { return }
        
        let weather = weatherList.first!
        
        if let description = weather.description {
            lblClimate.text = description
        }
        
        if let iconName = weather.icon {
            ivClimate.image = UIImage(named: iconName)
        }
    }

}
