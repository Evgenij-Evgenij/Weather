//
//  CurrentWeatherView.swift
//  Weather
//
//  Created by Евгений Воронов on 24.01.2023.
//

import SwiftUI

struct CurrentWeatherView: View {
    @ObservedObject var viewModel: ViewModel
    var body: some View {
        HStack(spacing: 60) {
            VStack {
                viewModel.refreshWeatherIcon(icon: viewModel.weatherIcon)
                    .font(.system(size: 100))
                    .offset(y: -20)
                
                Text("\(viewModel.tempereture)º")
                    .font(.title.bold())
            } 
            
            VStack(alignment: .leading) {
                CurrentWeatherConditions(image: "thermometer.medium" , condition: "\(viewModel.tempereture)º")
                
                //viewModel.tempereture
                
                CurrentWeatherConditions(image: "humidity.fill", condition: "\(viewModel.humidity)%")
              // Text(viewModel.windSpeed)
                CurrentWeatherConditions(image: "wind", condition: "\(viewModel.windSpeed)м/с", additionalImag: "arrow.up.forward")
            }
            
        }
        .foregroundColor(.white)
        .padding()
    }
}

struct CurrentWeatherView_Previews: PreviewProvider {
    static var previews: some View {
        CurrentWeatherView(viewModel: ViewModel())
            
            .background(Color.blue)
    }
}

struct CurrentWeatherConditions: View {
    @State var image: String
     var condition: String
     var additionalImag: String?
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: image)
                
                Text(condition)
                
                Image(systemName: additionalImag ?? "")
                
            }
            .padding(5)
        }
    }
}
