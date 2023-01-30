//
//  WeatherByNexDays.swift
//  Weather
//
//  Created by Евгений Воронов on 26.01.2023.
//

import SwiftUI

struct WeatherByNexDaysView: View {
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        VStack {
            ScrollView {
                if let weatherDya = viewModel.weather?.daily {
                    ForEach(weatherDya) { dayWeather in
                        LazyVStack {
                            DaylyWeatherCell(dayWeek: viewModel.getDayFor(timestamp: dayWeather.dt),
                                             temperetureMin: viewModel.getTempFor(temp: dayWeather.temp.min), temeratureMax: viewModel.getTempFor(temp: dayWeather.temp.max),
                                             icon: dayWeather.weather.count > 0 ? dayWeather.weather[0].icon : "sun.max")
                            .environmentObject(viewModel)
                            .background(self.viewModel.weather?.current.dt == dayWeather.dt ? Color.gray : Color.white)
                        }
                        
                        .foregroundColor(.black)
                    }
                }
            }
        }
        .background(RoundedRectangle(cornerRadius: 5).foregroundColor(.white).ignoresSafeArea())
        
    }
}

struct WeatherByNexDaysView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherByNexDaysView(viewModel: ViewModel())
    }
}
