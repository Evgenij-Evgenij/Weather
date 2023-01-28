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
    
    enum CodingKey: String {
        case dt
        case temp
        case weather
    }
    
//    init() {
//        dt = 0
//        temp = Tempereture(day: 0.0, min: 0.0, max: 0.0)
//        weather = [WeatherDetail(main: "", description: "", icon: "")]
//    }
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
