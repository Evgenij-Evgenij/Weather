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
    @State var currentregion: MKCoordinateRegion
    
    var body: some View {
        VStack {
            
            Map(coordinateRegion: $currentregion, showsUserLocation: true)
        }
        
        .overlay(content: {
            VStack {
                HStack {
                    Spacer()
                    Button(action: {
                        dismiss()
                    }, label: {
                        Image(systemName: "multiply")
                    })
                    .foregroundColor(.black)
                    .font(.title.bold())
                    .padding(30)
                }
                Spacer()
            }
            .padding()
        })
        .ignoresSafeArea()
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(currentregion: MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0), span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)))
    }
}
