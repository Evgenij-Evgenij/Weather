//
//  ModelWeather.swift
//  Weather
//
//  Created by Евгений Воронов on 24.01.2023.
//

import Foundation

struct ModelWeather: Codable {
    
    var current: Weather
    var hourly: [Weather]
    var daily: [DailyWeather]
    
//    static func empty() -> ModelWeather {
//        return ModelWeather(current: Weather(), hourly: [Weather](repeating: Weather(), count: 23), daily: [DailyWeather](repeating: DailyWeather(), count: 8))
//    }
    
//    struct Current: Codable {
//
//    }
//
//    struct Daily: Codable {
//
//        let dt: Date
//
//        struct Temp: Codable {
//
//            let day: Double
//            let min: Double
//            let max: Double
//
//        }
//        let temp: Temp
//    }
//    let daily: [Daily]
}
