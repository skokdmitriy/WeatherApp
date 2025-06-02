//
//  WeatherServiceProtocol.swift
//  WeatherApp
//
//  Created by Дмитрий Скок on 02.06.2025.
//

import Foundation

protocol WeatherServiceProtocol {
    func fetchWeatherForecast(for city: String) async throws -> WeatherResponse
    func searchCities(_ query: String) async throws -> [CityModel]
}
