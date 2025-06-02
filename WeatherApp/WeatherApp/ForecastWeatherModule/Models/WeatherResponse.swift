//
//  WeatherResponse.swift
//  WeatherApp
//
//  Created by Дмитрий Скок on 02.06.2025.
//

import Foundation

struct WeatherResponse: Decodable {
    let current: CurrentModel
    let forecast: ForecastResponse
}
