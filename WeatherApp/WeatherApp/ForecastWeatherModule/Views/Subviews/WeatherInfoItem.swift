//
//  WeatherInfoItem.swift
//  WeatherApp
//
//  Created by Дмитрий Скок on 02.06.2025.
//

import SwiftUI

struct WeatherInfoItem: View {
    let icon: String
    let value: String

    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.blue)
            Text(value)
                .font(.subheadline)
        }
    }
}
