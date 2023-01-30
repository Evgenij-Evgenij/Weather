//
//  WeatherByHours.swift
//  Weather
//
//  Created by Евгений Воронов on 24.01.2023.
//

import SwiftUI

struct WeatherByHoursVew: View {
    @ObservedObject var viewModel: ViewModel
    var body: some View {
        ScrollView(Axis.Set.horizontal, showsIndicators: false) {
            HStack {
                if let weatherH = viewModel.weather?.hourly {
                    ForEach(weatherH) { hour in
                        VStack(spacing: 5) {
                            Text("\(viewModel.getTime(timestamp: hour.dt))ºº")
                                .padding(.bottom, 15)
                            
                            viewModel.refreshWeatherIcon(icon: viewModel.weatherIcon)
                            Text("\(viewModel.getTempFor(temp: hour.temp))")
                        }
                        .foregroundColor(.white)
                        .font(.title3)
                        .padding(10)
                    }
                }
            }
        }
        .padding()
        .background(Color.blueMiddlecolor)
    }
}

struct WeatherByHoursView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherByHoursVew(viewModel: ViewModel())
    }
}

struct WeatherPerHour: View {
    @State var hour: String
    @State var image: String
    @State var degree: String
    var body: some View {
        VStack {
            Text(hour)
                .padding(.bottom, 15)
            
            Image(systemName: image)
            Text(degree)
        }
        .foregroundColor(.white)
        .font(.title2)
        .padding()
    }
}
