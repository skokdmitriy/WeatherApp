//
//  NetworkError.swift
//  WeatherApp
//
//  Created by Дмитрий Скок on 02.06.2025.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case networkError(Error)
    case decodingError(Error)

    var localizedDescription: String {
        switch self {
        case .invalidURL:
            Constants.invalidURL
        case .invalidResponse:
            Constants.invalidResponse
        case .networkError(let underlyingError):
            Constants.networkError + underlyingError.localizedDescription
        case .decodingError(let underlyingError):
            Constants.dataError + underlyingError.localizedDescription
        }
    }
}
