//
//  ModelWeather.swift
//  Weather
//
//  Created by Евгений Воронов on 24.01.2023.
//

import Foundation

struct ModelWeather: Codable {
    
    let current: Weather
    let hourly: [Weather]
    let daily: [DailyWeather]
}
