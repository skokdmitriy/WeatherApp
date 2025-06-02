//
//  WeatherDayRowView.swift
//  WeatherApp
//
//  Created by Дмитрий Скок on 02.06.2025.
//

import SwiftUI

struct WeatherDayRowView: View {
    let forecastDay: ForecastDayModel

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            headerView
            weatherConditionView
            weatherInfoView
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
    }
}

// MARK: - UI Components

private extension WeatherDayRowView {
    var headerView: some View {
        HStack {
            Text(forecastDay.date.formatDateString())
                .font(.headline)
            Spacer()
            Text(forecastDay.day.avgTempString)
                .font(.title2)
                .bold()
        }
    }

    var weatherConditionView: some View {
        HStack {
            AsyncImage(url: forecastDay.day.condition.iconURL) { image in
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
            .frame(width: 25, height: 25)
            Text(forecastDay.day.condition.text)
                .font(.subheadline)
        }
    }

    var weatherInfoView: some View {
        HStack(spacing: 20) {
            WeatherInfoItem(
                icon: "wind",
                value: forecastDay.day.maxWindString
            )
            WeatherInfoItem(
                icon: "humidity",
                value: forecastDay.day.avgHumidityString
            )
        }
    }
}
