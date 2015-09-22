//
//  DailyWeather.swift
//  Stormy
//
//  Created by Лидия Хашина on 22.09.15.
//  Copyright © 2015 OnlineLab. All rights reserved.
//

import Foundation
import UIKit

struct DailyWeather {
    
    let maxTemperature: Int?
    let minTemperature: Int?
    let humidity: Int?
    let precipChance: Int?
    let summary: String?
    var icon: UIImage? = UIImage(named: "default.png")
    var largeIcon: UIImage? = UIImage(named: "default_large.png")
    let sunriseTime: String?
    let sunsetTime: String?
    let day: String?
    
    init(dailyWeatherDictionary: [String: AnyObject]) {
        
        maxTemperature = dailyWeatherDictionary["temperatureMax"] as? Int
        if let humidityFloat = dailyWeatherDictionary["humidity"] as? Double {
            humidity = Int(humidityFloat * 100)
        } else {
            humidity = nil
        }
        if let precipChanceFloat = dailyWeatherDictionary["precipProbability"] as? Double {
            precipChance = Int(precipChanceFloat * 100)
        } else {
            precipChance = nil
        }
        summary = dailyWeatherDictionary["summary"] as? String
    }
}