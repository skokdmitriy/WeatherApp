//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Дмитрий Скок on 02.06.2025.
//

import SwiftUI
import Combine

enum WeatherViewState {
    case loading
    case error(String)
    case loaded
}

@MainActor
final class WeatherViewModel: ObservableObject {
    @Published var currentCity: String = Constants.defaultCity
    @Published var searchText: String = ""

    @Published private(set) var state: WeatherViewState = .loading
    @Published private(set) var isSearching = false
    @Published private(set) var current: CurrentModel?
    @Published private(set) var forecast: [ForecastDayModel] = []
    @Published private(set) var filteredCities: [CityModel] = []

    private let weatherService: WeatherServiceProtocol
    private let locationManager: LocationManager
    private var cancellables = Set<AnyCancellable>()

    init(
        weatherService: WeatherServiceProtocol,
        locationManager: LocationManager
    ) {
        self.weatherService = weatherService
        self.locationManager = locationManager
        setupSearchSubscription()
        setupLocationSubscriptions()
    }

    func fetchWeather(for city: String) async {
        state = .loading
        do {
            let response = try await weatherService.fetchWeatherForecast(for: city)
            current = response.current
            forecast = response.forecast.forecastday
            state = .loaded
        } catch let error as NetworkError {
            state = .error(error.localizedDescription)
        } catch {
            state = .error(Constants.unexpectedError + error.localizedDescription)
        }
    }

    func requestLocation() {
        locationManager.requestLocation()
    }

    func didSelectCity(_ city: CityModel) {
        searchText = ""
        currentCity = city.name
        Task {
            await fetchWeather(for: city.name)
        }
        filteredCities = []
    }

    func didSelectBack() {
        Task {
            await self.fetchWeather(for: Constants.defaultCity)
        }
    }

    // MARK: - Private Methods

    private func setupSearchSubscription() {
        $searchText
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            .removeDuplicates()
            .filter { $0.count >= 3 }
            .sink { [weak self] query in
                guard !query.isEmpty else {
                    self?.filteredCities = []
                    return
                }
                Task {
                    await self?.searchCities(query)
                }
            }
            .store(in: &cancellables)
    }

    private func searchCities(_ query: String) async {
        do {
            let cities = try await weatherService.searchCities(query)
            await MainActor.run {
                self.filteredCities = cities
            }
        } catch {
            print("Search error: \(error.localizedDescription)")
        }
    }

    private func setupLocationSubscriptions() {
        locationManager.$locationString
            .dropFirst()
            .sink { [weak self] city in
                guard let self,
                      !city.isEmpty else {
                    return
                }
                Task {
                    self.currentCity = city
                    await self.fetchWeather(for: city)
                }
            }
            .store(in: &cancellables)

        locationManager.$isLocationDenied
            .dropFirst()
            .sink { [weak self] isDenied in
                guard let self, isDenied else {
                    return
                }
                Task {
                    await self.fetchWeather(for: Constants.defaultCity)
                }
            }
            .store(in: &cancellables)
    }
}
