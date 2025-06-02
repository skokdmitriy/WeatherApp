//
//  Constants.swift
//  WeatherApp
//
//  Created by Дмитрий Скок on 02.06.2025.
//

import Foundation

enum Constants {
    static let baseURL = "https://api.weatherapi.com/v1"
    static let forecast = "/forecast.json"
    static let search = "/search.json"

    static let defaultCity = "Moscow"

    static let invalidURL = "Invalid URL: Unable to create request URL for city "
    static let invalidResponse = "Invalid Response: Server returned an invalid response"
    static let networkError = "Network Error: "
    static let dataError = "Data Error: "
    static let unexpectedError = "Unexpected Error: "
}
