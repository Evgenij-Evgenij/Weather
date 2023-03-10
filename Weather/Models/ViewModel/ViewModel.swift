//
//  ViewModel.swift
//  Weather
//
//  Created by Евгений Воронов on 24.01.2023.
//

import SwiftUI
import CoreLocation
import MapKit

final class ViewModel: ObservableObject {
    
    var myDay = Date()
    var currentLocationCity = CLLocation(latitude: 0.0, longitude: 0.0)
    
    @Published var weather: ModelWeather?
    private var locationManager = LocationManager()
    @Published var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 0, longitude: 0), span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
    @Published var isShowMap = false
    @Published var currentCity = ""
    @Published var searchPlaces: [CLPlacemark] = []
    @Published var searchCity = "" {
        didSet {
            getLocation()
        }
    }
    
    // MARK: formating date
    
    var currendDateFormatter: DateFormatter {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE"
        return formatter
    }
    
    private var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "E,dd,MMM"
        return formatter
    }()
    
    private var dayFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE"
        return formatter
    }()
    
    private var timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()
    
    var date: String {
        guard let weather = weather else {
            return ""
        }
        
        return dateFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(weather.current.dt)))
    }
    
    var weatherIcon: String {
        guard let weather = weather else {
            return "sun.max.fill"
        }
        
        if weather.current.weather.count > 0 {
            return weather.current.weather[0].icon
        }
        return "sun.max.fill"
    }
    
    var tempereture: String {
        guard let weather = weather else {
            return "0"
        }
        return getTempFor(temp: weather.current.temp)
        
    }
    
    var conditions: String {
        guard let weather = weather else {
            return ""
        }
        if weather.current.weather.count > 0 {
            return weather.current.weather[0].main
        }
        return ""
    }
    
    var windSpeed: String {
        guard let weather = weather else {
            return "0.0"
        }
        return String(format: "%0.1f", weather.current.wind_speed)
    }
    
    var humidity: String {
        guard let weather = weather else {
            return ""
        }
        
        return String(format: "%d%%", weather.current.humidity)
    }
    
    var rainChances: String {
        guard let weather = weather else {
            return ""
        }
        
        return String(format: "%0.0f%%", weather.current.dew_point)
    }
    
    init() {
        locationManager.locationCallBack = { [weak self] location in
            guard let self = self else {return}
            self.getLocation(coordinates: location)
            self.region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude), span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
            self.currentLocationCity = CLLocation(latitude: location.latitude, longitude: location.longitude)
            
        }
        
    }
    
    func getTime(timestamp: Int) -> String {
        return timeFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(timestamp)))
    }
    
    func getTempFor(temp: Double) -> String {
        return String(format: "%0.1f", temp)
    }
    
    func getDayFor(timestamp: Int) -> String {
        return dayFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(timestamp)))
    }
    
    private func getLocation(coordinates: CLLocationCoordinate2D? = nil) {
        if searchCity != "" {
            CLGeocoder().geocodeAddressString(searchCity) { plasemarks, error in
                if let places = plasemarks, let place = places.first {
                    self.getWeather(coord: place.location?.coordinate)
                    self.searchPlaces = places
                    print(places)
                }
            }
        } else {
            currentLocationCity.fetchCity(completion: { city, _, error in
                guard let city = city, error == nil else {return}
                self.currentCity = String(city)
            })
            getWeather(coord: coordinates)
        }
    }
    
    private func getWeather(coord: CLLocationCoordinate2D?) {
        guard let coord = coord else {return}
            let urlString = ApiKey.getAPIUrl(lat: coord.latitude, long: coord.longitude)
            getWeatherInternal(city: searchCity, for: urlString)
    }
    
    private func getWeatherInternal(city: String, for urlString: String) {
        NetworkManager.fetchData(urlString: urlString) { (result) in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self.weather = response
                }
            case .failure(let err):
                print(err)
            }
        }
    }
    
    // MARK: Icon weather
    
    func refreshWeatherIcon(icon: String) -> Image {
        switch icon {
        case "01d": return Image(systemName: "sun.max")
        case "01n": return Image(systemName: "moon.stars")
        case "02d": return Image(systemName: "cloud.sun")
        case "02n": return Image(systemName: "cloud.moon")
        case "03d", "03n", "04d", "04n": return Image(systemName: "cloud")
        case "09d","09n": return Image(systemName: "cloud.drizzle")
        case "10d", "10n": return Image(systemName: "cloud.rain")
        case "11d", "11n": return Image(systemName: "cloud.bolt")
        case "13d", "13n": return Image(systemName: "cloud.snow")
        case "50d", "50n": return Image(systemName: "cloud.fog")
        default:
            return Image(systemName: "sun.max")
        }
    }
}

