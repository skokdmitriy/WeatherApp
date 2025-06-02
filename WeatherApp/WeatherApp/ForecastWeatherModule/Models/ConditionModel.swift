//
//  ConditionModel.swift
//  WeatherApp
//
//  Created by Дмитрий Скок on 02.06.2025.
//

import Foundation

struct ConditionModel: Decodable, Hashable {
    let text: String
    let icon: String
    let code: Int

    var iconURL: URL? {
        URL(string: "https:\(icon)")
    }
}
