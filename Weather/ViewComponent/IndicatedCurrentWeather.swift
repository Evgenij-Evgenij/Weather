//
//  IndicatedCurrentWeather.swift
//  Weather
//
//  Created by Евгений Воронов on 30.01.2023.
//

import SwiftUI

struct IndicatedCurrentWeather: View {
    let style: Style
   
    var body: some View {
        Rectangle()
            .stroke(style.backgroundColor)
            .blur(radius: 1.5)
    }
}

struct IndicatedCurrentWeather_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 30) {
            IndicatedCurrentWeather(
                               style: .blue)
            
            IndicatedCurrentWeather(
                               style: .white)
        }
        .padding()
        .background(Color.gray)
        .previewLayout(.sizeThatFits)
    }
}

extension IndicatedCurrentWeather {
    
    enum Style {
        case blue, white
        
        var backgroundColor: Color {
            switch self {
            case .blue: return .colorShadow
            case .white: return .white
            }
        }
    }
}

