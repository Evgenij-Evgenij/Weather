//
//  Weather.swift
//  Weather
//
//  Created by Евгений Воронов on 24.01.2023.
//

import Foundation

struct Weather: Codable, Identifiable {
    var dt: Int
    var temp: Double
    var pressure: Int
    var humidity: Int
    var dew_point: Double
    var clouds: Int
    var wind_speed: Double
    var wind_deg: Int
    var wind_gust: Double
    var weather: [WeatherDetail]
    
    enum CodingKey: String {
        case dt
        case temp
        case pressure
        case humidity
        case dew_point
        case clouds
        case wind_speed
        case wind_deg
        case wind_gust 
        case weather
    }
}

extension Weather {
    var id: UUID {
        return UUID()
    }
}
