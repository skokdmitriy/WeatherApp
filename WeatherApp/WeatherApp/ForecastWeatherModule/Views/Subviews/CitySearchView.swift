//
//  CitySearchView.swift
//  WeatherApp
//
//  Created by Дмитрий Скок on 02.06.2025.
//

import SwiftUI

struct CitySearchView: View {
    @ObservedObject var viewModel: WeatherViewModel
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack {
            HStack {
                TextField("Enter city name (at least 3 letters)", text: $viewModel.searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                Button("Cancel") {
                    viewModel.searchText = ""
                    dismiss()
                }
            }
            .padding()

            if viewModel.isSearching {
                ProgressView()
                    .padding()
            } else {
                List(viewModel.filteredCities) { city in
                    Text(city.name)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            viewModel.didSelectCity(city)
                            dismiss()
                        }
                }
                .listStyle(PlainListStyle())
                .cornerRadius(12)
                .padding()
            }
        }
        .frame(alignment: .top)
    }
}
