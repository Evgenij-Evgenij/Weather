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
}
