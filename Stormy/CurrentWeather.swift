//
//  CurrentWeather.swift
//  Stormy
//
//  Created by Лидия Хашина on 01.09.15.
//  Copyright (c) 2015 OnlineLab. All rights reserved.
//

import Foundation

struct CurrentWeather {
    
    let temperature: Int?
    let humidity: Int?
    let precipProbabitily: Int?
    let summary: String?
    
    init(weatherDictionary: [String: AnyObject]) {
        temperature = weatherDictionary["temperature"] as? Int
        if let humidityFloat = weatherDictionary["humidity"] as? Double{
           humidity = Int(humidityFloat * 100)
        } else {
            humidity = nil
        }
        if let precipFloat = weatherDictionary["precipProbability"] as? Double {
            precipProbabitily = Int(precipFloat * 100)
        } else {
            precipProbabitily = nil
        }
        summary = weatherDictionary["summary"] as? String
    }
}