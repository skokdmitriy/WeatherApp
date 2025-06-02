//
//  WeatherService.swift
//  WeatherApp
//
//  Created by Дмитрий Скок on 02.06.2025.
//

import Foundation

final class WeatherService: WeatherServiceProtocol {
    private let networkService: NetworkServiceProtocol = NetworkService.shared
    private let apiKey = "b42df8904249432dbfe100054253005"

    private enum Endpoint {
        case forecast(city: String)
        case search(query: String)

        var path: String {
            switch self {
            case .forecast:
                return Constants.forecast
            case .search:
                return Constants.search
            }
        }

        var queryItems: [URLQueryItem] {
            switch self {
            case .forecast(let city):
                return [
                    URLQueryItem(name: "q", value: city),
                    URLQueryItem(name: "days", value: "5")
                ]
            case .search(let query):
                return [
                    URLQueryItem(name: "q", value: query)
                ]
            }
        }
    }

    func fetchWeatherForecast(for city: String) async throws -> WeatherResponse {
        try await performRequest(
            endpoint: .forecast(city: city),
        )
    }

    func searchCities(_ query: String) async throws -> [CityModel] {
        try await performRequest(
            endpoint: .search(query: query),
        )
    }

    // MARK: - Private Methods

    private func makeURL(for endpoint: Endpoint) throws -> URL {
        guard var components = URLComponents(string: Constants.baseURL + endpoint.path) else {
            throw NetworkError.invalidURL
        }

        var items = endpoint.queryItems
        items.append(URLQueryItem(name: "key", value: apiKey))
        components.queryItems = items

        guard let url = components.url else {
            throw NetworkError.invalidURL
        }
        return url
    }

    private func performRequest<T: Decodable>(endpoint: Endpoint) async throws -> T {
        let url = try makeURL(for: endpoint)

        do {
            return try await networkService.fetch(from: url)
        } catch let error as NetworkError {
            throw error
        } catch {
            throw NetworkError.networkError(error)
        }
    }
}
