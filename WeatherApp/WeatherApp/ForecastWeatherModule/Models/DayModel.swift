//
//  DayModel.swift
//  WeatherApp
//
//  Created by Дмитрий Скок on 02.06.2025.
//

import Foundation

struct DayModel: Decodable, Hashable {
    let avgTemp: Double
    let maxWindKph: Double
    let avgHumidity: Int
    let condition: ConditionModel

    private enum CodingKeys: String, CodingKey {
        case avgTemp = "avgtemp_c"
        case maxWindKph = "maxwind_kph"
        case avgHumidity = "avghumidity"
        case condition
    }

    var avgTempString: String {
        String("\(Int(avgTemp))°C")
    }
    var maxWindString: String {
        String("\(Int(maxWindKph)) km/h")
    }
    var avgHumidityString: String {
        String("\(avgHumidity)%")
    }
}
