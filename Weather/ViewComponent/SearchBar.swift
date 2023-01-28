//
//  SearchBar.swift
//  Weather
//
//  Created by Евгений Воронов on 24.01.2023.
//

import SwiftUI

struct SearchBar: View {
    @EnvironmentObject var viewModel: ViewModel
    
    @Environment(\.dismiss) var dismiss
    var title = "Введіть назву міста"
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "chevron.left")
                    .font(.title2)
                    .onTapGesture {
                        dismiss()
                    }
                
                TextField(title, text: $viewModel.city)
                    .padding(5)
                    .background(RoundedRectangle(cornerRadius: 5).foregroundColor(.white))
                
                Image(systemName: "magnifyingglass")
                
            }
            .foregroundColor(.black)
            .padding()
            .background(Color.blueTopColor)
            
            Spacer()
        }
        .navigationBarBackButtonHidden()
        
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar()
            .environmentObject(ViewModel())
    }
}

