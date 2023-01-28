//
//  MapView.swift
//  Weather
//
//  Created by Евгений Воронов on 27.01.2023.
//
import MapKit
import SwiftUI

struct MapView: View {
    @Environment(\.dismiss) var dismiss
    @State private var map = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 47.910439, longitude: 33.391655), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
    
    var body: some View {
        VStack {
          
            Map(coordinateRegion: $map, showsUserLocation: true)
        }
        .overlay(content: {
            VStack {
                HStack {
                    Spacer()
                    Image(systemName: "multiply")
                        .onTapGesture {
                            dismiss()
                        }
                        .font(.title.bold())
                        .padding(40)
                   
                }
                Spacer()
            }
        })
        .ignoresSafeArea()
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
