//
//  ViewModel.swift
//  Weather
//
//  Created by Евгений Воронов on 24.01.2023.
//

import SwiftUI
import CoreLocation

final class ViewModel: ObservableObject {
    @Published var isShowMap = false
   // @Published var region = MKCoordinateRegion(center: getLocation(<#T##self: ViewModel##ViewModel#>), span: <#T##MKCoordinateSpan#>)
    @Published var weather: ModelWeather?
    var locationManager = LocationManager()
//    @Published var currentDate
   
    
    @Published var city = "" { //Kryvyi Rih
        didSet {
            getLocation()
        }
    }

    // MARK: formating date
    
    private var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EE, MMM, d" // .full
        
        return formatter
    }()
    
    private var dayFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE"
        
        return formatter
    }()
    
    private var timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh a"
        return formatter
    }()
    
    init() {
        DispatchQueue.main.async {
            
            
            self.getLocation { [weak self] coordinate in
                guard let self else {return}
                self.getWeather(coord: coordinate)
            }
            
            self.getWeather(coord: self.locationManager.lastLocation?.coordinate)
        }
       
//        getLocation(completion: getWeather(coord: locationManager.lastLocation?.coordinate))
    }
    
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
        print("Температуа \(weather.current.temp)")
        return getTempFor(temp: weather.current.temp)
       
    }
    
    
    // cloudy or sunny or rain or snow(погода на улице  солнечная или пасмкрная ит и тп)
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
        print("скорость ветра \(weather.current.wind_speed)")
         return String(format: "%0.1f", weather.current.wind_speed)
        //return String(weather.current.wind_speed)
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
    
    // ------------
    
    
    
    func getTime(timestamp: Int) -> String {
        return timeFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(timestamp)))
    }
    
    func getTempFor(temp: Double) -> String {
        return String(format: "%0.1f", temp)
    }
    
    func getDayFor(timestamp: Int) -> String {
        return dayFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(timestamp)))
    }
    
    private func getLocation(complition: ((CLLocationCoordinate2D?) -> ())? = nil) {
        if city != "" {
            CLGeocoder().geocodeAddressString(city) { plasemarks, error in
                if let places = plasemarks, let place = places.first {
                    self.getWeather(coord: place.location?.coordinate)
                }
            }
            guard let coordinate = locationManager.lastLocation?.coordinate else { return }
            complition?(coordinate)
        } else {
            getWeather(coord: locationManager.lastLocation?.coordinate)
        }
    }
    
//    private func getLocation() {
//        if city != "" {
//            CLGeocoder().geocodeAddressString(city) { placemarks, error in
//                if let places = placemarks, let place = places.first {
//                    self.getWeather(coord: place.location?.coordinate)
//                }
//            }
//        } else {
//            getWeather(coord: locationManager.lastLocation?.coordinate)
//        }
////        CLGeocoder().geocodeAddressString(city) { [weak self] placemarks, error in
////            if let places = placemarks, let place = places.first {
////                self?.getWeather(coord: place.location?.coordinate)
////            }
////            else {
////                //getWeather(coord: self!.locationManager.lastLocation )
////            }
////        }
//    }
    
    
    private func getWeather(coord: CLLocationCoordinate2D?) {
        if let coord = coord {
             let urlString = ApiKey.getAPIUrl(lat: coord.latitude, long: coord.longitude)
            getWeatherInternal(city: city, for: urlString)
            print("----\(urlString)----")
        } else {
           // let urlStrig = ApiKey.getAPIUrl(lat: 47.910968, long: 33.391757)
            let urlStr = ApiKey.getAPIUrl(lat: locationManager.lastLocation?.coordinate.latitude ?? 0, long: locationManager.lastLocation?.coordinate.longitude ?? 0)
            getWeatherInternal(city: city, for: urlStr)
            print("11111---\(urlStr)---11111")
        }
       
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
    
//    private func getLocationName() -> String {
//        let 
//    }
    
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
          return  Image(systemName: "moon.stars")
        }
    }
}

//
