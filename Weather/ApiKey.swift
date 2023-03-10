//
//  APIKey.swift
//  Weather
//
//  Created by Evgenij Voronov on 24.01.2023.
//

import Foundation

struct ApiKey {
    static let apiKey = "541000f642b968899e2b401d3112a355"
    //61c3043a5d1be3d53542c7f1f88b4792
    //541000f642b968899e2b401d3112a355
     
    static func getAPIUrl(lat: Double, long: Double) -> String {
        return "https://api.openweathermap.org/data/3.0/onecall?lat=\(lat)&lon=\(long)&lang=ua&exclude=minutely,alerts&units=metric&appid=\(apiKey)"
    }
}


