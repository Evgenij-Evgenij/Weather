//
//  DaylyWeatherCell.swift
//  Weather
//
//  Created by Евгений Воронов on 26.01.2023.
//

import SwiftUI

struct DaylyWeatherCell: View {
    @EnvironmentObject var viewModel: ViewModel
    var dayWeek: String
    var temperetureMin: String
    var temeratureMax: String
    var icon: String
    var body: some View {
        HStack {
            Text(dayWeek.uppercased())
            
            Spacer()
            
            Text("\(temperetureMin)º/\(temeratureMax)º")
            
            Spacer()
            
            viewModel.refreshWeatherIcon(icon: icon)
        }
        .font(.title2.bold())
        .background(Color.white)
        .padding()
    }
}

struct DaylyWeatherCell_Previews: PreviewProvider {
    static var previews: some View {
        DaylyWeatherCell(dayWeek: "HB", temperetureMin: "0", temeratureMax: "10", icon: "01d")
            .environmentObject(ViewModel()) 
    }
}
