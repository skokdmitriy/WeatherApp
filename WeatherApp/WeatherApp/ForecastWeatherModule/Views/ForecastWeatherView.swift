//
//  ForecastWeatherView.swift
//  WeatherApp
//
//  Created by Дмитрий Скок on 02.06.2025.
//

import SwiftUI

struct ForecastWeatherView: View {
    @ObservedObject var viewModel: WeatherViewModel
    @State private var showingSearch = false

    var body: some View {
        NavigationView {
            ZStack {
                Color(.systemGroupedBackground)
                    .ignoresSafeArea()
                switch viewModel.state {
                case .loading:
                    ProgressView()
                case .error(let message):
                    makeErrorView(message: message)
                case .loaded:
                    forecastView
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    if case .loaded = viewModel.state {
                        Button {
                            showingSearch = true
                        } label: {
                            Image(systemName: "magnifyingglass")
                        }
                    }
                }
            }
            .sheet(isPresented: $showingSearch) {
                CitySearchView(viewModel: viewModel)
            }
        }
        .onAppear() {
            viewModel.requestLocation()
        }
    }
}

// MARK: - UI Components

private extension ForecastWeatherView {
    var forecastView: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 16) {
                if let current = viewModel.current {
                    CurrentWeatherView(
                        currentCity: viewModel.currentCity,
                        current: current
                    )
                    .padding()
                }
                
                LazyVStack(spacing: 16) {
                    ForEach(viewModel.forecast, id: \.self) { day in
                        WeatherDayRowView(forecastDay: day)
                            .padding(.horizontal)
                    }
                }
                .padding(.vertical)
            }
        }
    }

    func makeErrorView(message: String) -> some View {
        VStack {
            Text("Error: \(message)")
                .foregroundColor(.red)
            Button("Back") {
                viewModel.didSelectBack()
            }
            .buttonStyle(.bordered)
        }
        .frame(maxWidth: .infinity, alignment: .center)
    }
}

