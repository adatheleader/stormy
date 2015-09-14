//
//  CurrentWeather.swift
//  Stormy
//
//  Created by Лидия Хашина on 01.09.15.
//  Copyright (c) 2015 OnlineLab. All rights reserved.
//

import Foundation
import UIKit


enum Icon: String {
    case ClearDay = "clear-day"
    case ClearNight = "clear-night"
    case Rain = "rain"
    case Snow = "snow"
    case Sleet = "sleet"
    case Wind = "wind"
    case Fog = "fog"
    case Cloudy = "cloudy"
    case PartlyCloudyDay = "partly-cloudy-day"
    case PartlyCloudyNight = "partly-cloudy-night"
}




struct CurrentWeather {
    
    let temperature: Int?
    let humidity: Int?
    let precipProbabitily: Int?
    let summary: String?
    var icon: UIImage? = UIImage(named: "default.png")
    
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
        
        if let iconString = weatherDictionary["icon"] as? String {
            icon = weatherImageFromIconString(iconString)
        }
    }
    
    func weatherImageFromIconString(iconString: String) -> UIImage? {
        var imageName: String
        
        if let iconValue = Icon(rawValue: iconString) {
            switch iconValue {
            case .ClearDay:
                imageName = "clear-day.png"
            case .ClearNight:
                imageName = "clear-night.png"
            case .Rain:
                imageName = "rain.png"
            case .Snow:
                imageName = "snow.png"
            case .Sleet:
                imageName = "sleet.png"
            case .Wind:
                imageName = "wind.png"
            case .Fog:
                imageName = "fog.png"
            case .Cloudy:
                imageName = "cloudy.png"
            case .PartlyCloudyDay:
                imageName = "cloudy-day.png"
            case .PartlyCloudyNight:
                imageName = "cloudy-night.png"
            }
        } else {
            imageName = "default.png"
        }
        return UIImage(named: imageName)
    }
    
}