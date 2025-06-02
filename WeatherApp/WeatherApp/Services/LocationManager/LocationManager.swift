//
//  LocationManager.swift
//  WeatherApp
//
//  Created by Дмитрий Скок on 02.06.2025.
//

import Foundation
import CoreLocation

final class LocationManager: NSObject, ObservableObject {
    @Published var locationString: String = ""
    @Published var isLocationDenied: Bool = false

    private var location: CLLocation?
    private var authorizationStatus: CLAuthorizationStatus = .notDetermined
    private let locationManager = CLLocationManager()

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        authorizationStatus = locationManager.authorizationStatus
    }

    func requestLocation() {
        locationManager.requestWhenInUseAuthorization()
    }

    // MARK: - Private Methods

    private func getLocationString() async -> String {
        guard let location else {
            return ""
        }

        let geocoder = CLGeocoder()
        do {
            let placemarks = try await geocoder.reverseGeocodeLocation(location)
            if let placemark = placemarks.first {
                if let city = placemark.locality {
                    return city
                }
            }
        } catch {
            print("Geocoding error: \(error.localizedDescription)")
        }
        return ""
    }
}

// MARK: - CLLocationManagerDelegate

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        self.location = location
        
        Task {
            let city = await getLocationString()
            await MainActor.run {
                self.locationString = city
            }
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location manager failed with error: \(error.localizedDescription)")
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.requestLocation()
        case .denied, .restricted:
            isLocationDenied = true
        case .notDetermined:
            break
        default:
            break
        }
    }
}
