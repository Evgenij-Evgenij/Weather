//
//  ButtonLocation.swift
//  Weather
//
//  Created by Евгений Воронов on 24.01.2023.
//

import SwiftUI

struct ButtonLocationView: View {
    @ObservedObject var viewModel: ViewModel
    var body: some View {
        HStack {
            Button {
                viewModel.isShowMap.toggle()
            } label: {
                Image(systemName: "mappin.and.ellipse")
            }
            
            Text(viewModel.searchCity.isEmpty ? viewModel.currentCity : viewModel.searchCity)
            
            Spacer()
            
            NavigationLink {
                SearchBar()
                    .environmentObject(viewModel)
            } label: {
                ZStack {
                    Image(systemName: "scope")
                    Image(systemName: "smallcircle.filled.circle")
                }
            }
        }
        .foregroundColor(.white)
        .font(.title2)
        .padding()
        .padding(.top, 50)
    }
}

struct ButtonLocation_Previews: PreviewProvider {
    static var previews: some View {
        ButtonLocationView(viewModel: ViewModel())
            .background(Color.blue)
        
    }
}
