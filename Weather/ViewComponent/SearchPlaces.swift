//
//  SearchPlaces.swift
//  Weather
//
//  Created by Evgenij Voronov on 02.02.2023.
//

import SwiftUI

struct SearchPlaces: View {
    var action: (() -> Void)
    @EnvironmentObject var viewModel: ViewModel
    var body: some View {
        ScrollView {
            ForEach(viewModel.searchPlaces, id: \.self) { place in
                Text(place.name ?? "")
                    .onTapGesture {
                        viewModel.searchCity = place.name ?? ""
                        action()
                }
            }
        }
    }
}

struct SearchPlaces_Previews: PreviewProvider {
    static var previews: some View {
        SearchPlaces(action: {})
            .environmentObject(ViewModel())
    }
}
