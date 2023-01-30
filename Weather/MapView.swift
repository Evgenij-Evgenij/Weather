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
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        VStack {
            
            Map(coordinateRegion: $viewModel.region, showsUserLocation: true)
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
        MapView(viewModel: ViewModel())
    }
}
