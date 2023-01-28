//
//  Extension.swift
//  Weather
//
//  Created by Евгений Воронов on 24.01.2023.
//

import SwiftUI

extension Color {
   static var blueTopColor = Color("blueWeatherColorTop")
    static var blueMiddlecolor =  Color("blueWeatherColorMiddle")
} 


extension Image {
    static var currentDegree = "thermometer.medium"
    static var searchTextIcon = "seatchText"
    static var currentWindIcon = "wind"
}

//enum Icon {
//    case currentDegree
//    case currentWindIcon
//    
//    var iconName: String {
//        switch.self {
//        case .currentDegree: "thermometer.medium"
//        case .currentWindIcon: "wind"
//        }
//    }
//}
