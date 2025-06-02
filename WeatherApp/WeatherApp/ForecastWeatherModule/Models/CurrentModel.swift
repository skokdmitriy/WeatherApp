//
//  CurrentModel.swift
//  WeatherApp
//
//  Created by Дмитрий Скок on 02.06.2025.
//

import Foundation

struct CurrentModel: Decodable {
    let temp: Double
    let condition: ConditionModel
    let windKph: Double
    let humidity: Double
    let feelsLike: Double

    private enum CodingKeys: String, CodingKey {
        case temp = "temp_c"
        case condition
        case windKph = "wind_kph"
        case humidity
        case feelsLike = "feelslike_c"
    }

    var tempeString: String {
        String("\(Int(temp))°C")
    }
    var feelsLikeString: String {
        String("Feels like \(Int(feelsLike))°C")
    }
    var windString: String {
        String("\(Int(windKph)) km/h")
    }
    var humidityString: String {
        String("\(Int(humidity))%")
    }
}
