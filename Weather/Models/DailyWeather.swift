//
//  DailyWeather.swift
//  Weather
//
//  Created by Евгений Воронов on 24.01.2023.
//

import Foundation

struct DailyWeather: Codable, Identifiable {
    var dt: Int
    var temp: Tempereture
    var weather: [WeatherDetail]
}

extension DailyWeather {
    var id: UUID {
        return UUID()
    }
}



struct Tempereture: Codable {
    var day: Double
    var min: Double
    var max: Double
}
