//
//  NetworkServiceProtocol.swift
//  WeatherApp
//
//  Created by Дмитрий Скок on 02.06.2025.
//

import Foundation

protocol NetworkServiceProtocol {
    func fetch<T: Decodable>(from url: URL) async throws -> T
}
