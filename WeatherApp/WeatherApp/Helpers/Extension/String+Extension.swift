//
//  String+Extension.swift
//  WeatherApp
//
//  Created by Дмитрий Скок on 02.06.2025.
//

import Foundation

extension String {
    func formatDateString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        guard let date = formatter.date(from: self) else {
            return self
        }
        formatter.dateFormat = "EEEE, MMM d"
        return formatter.string(from: date)
    }
}
