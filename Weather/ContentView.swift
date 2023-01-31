//
//  ContentView.swift
//  Weather
//
//  Created by Евгений Воронов on 24.01.2023.
// 

import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    
                    ButtonLocationView(viewModel: viewModel)
                    
                    CurrentDayAndDate(currentDay: viewModel.date)
                    
                    CurrentWeatherView(viewModel: viewModel)
                    
                    WeatherByHoursVew(viewModel: viewModel)
                    
                }
                
                WeatherByNexDaysView(viewModel: viewModel)
            }
            .fullScreenCover(isPresented: $viewModel.isShowMap, content: {
                MapView(currentregion: viewModel.region)
            })
            .ignoresSafeArea()
            .background(Color.blueTopColor)
        }
        .navigationViewStyle(.stack)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        
    }
}


struct CurrentDayAndDate: View {
    var currentDay: String
    var body: some View {
        HStack {
            Text(currentDay)
                .font(.caption)
                .foregroundColor(.white)
            
            Spacer()
        }
        .padding(.horizontal)
        .padding(.vertical, 5)
    }
}
