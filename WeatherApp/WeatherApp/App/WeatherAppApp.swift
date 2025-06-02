//
//  WeatherAppApp.swift
//  WeatherApp
//
//  Created by Дмитрий Скок on 02.06.2025.
//

import SwiftUI

@main
struct WeatherAppApp: App {
    @StateObject private var viewModel = WeatherViewModel(
        weatherService: WeatherService(),
        locationManager: LocationManager()
    )

    var body: some Scene {
        WindowGroup {
            ForecastWeatherView(viewModel: viewModel)
        }
    }
}
