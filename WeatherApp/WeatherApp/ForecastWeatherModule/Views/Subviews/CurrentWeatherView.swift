//
//  CurrentWeatherView.swift
//  WeatherApp
//
//  Created by Дмитрий Скок on 02.06.2025.
//

import SwiftUI

struct CurrentWeatherView: View {
    let currentCity: String
    let current: CurrentModel

    var body: some View {
        VStack {
            Text(currentCity)
                .font(.system(size: 50, weight: .bold))
                .multilineTextAlignment(.center)
            VStack {
                Text(current.tempeString)
                    .font(.system(size: 44, weight: .regular))
                Text(current.feelsLikeString)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            HStack {
                AsyncImage(url: current.condition.iconURL) { image in
                    switch image {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    default:
                        Image(systemName: "photo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(.gray)
                    }
                }
                .frame(width: 50, height: 50)
                Text(current.condition.text)
                    .font(.title3)
                    .multilineTextAlignment(.center)
            }
            HStack(spacing: 20) {
                WeatherInfoItem(
                    icon: "wind",
                    value: current.windString
                )
                WeatherInfoItem(
                    icon: "humidity",
                    value: current.humidityString
                )
            }
        }
        .padding(.horizontal)
    }
}
