//
//  ForecastDayModel.swift
//  WeatherApp
//
//  Created by Дмитрий Скок on 02.06.2025.
//

import Foundation

struct ForecastDayModel: Decodable, Hashable {
    let date: String
    let day: DayModel
}

struct ForecastResponse: Decodable {
    let forecastday: [ForecastDayModel]
}
