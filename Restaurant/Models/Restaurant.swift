//
//  Restaurant.swift
//  Restaurant
//
//  Created by Leonardo Zimmerman on 17/02/2021.
//  Copyright © 2021 Leonardo Zimmerman. All rights reserved.
//

import Foundation

class Restaurant: Codable {
    let id: Int
    let name: String
    let latitude: Double
    let longitude: Double
    let address: String
    let city: String
    let zipcode: String
    let currencyCode: String
    let cardPrice: Int
    let tripAdvisorAverageRate: Double
    let tripAdvisorRateCount: Int
    let averageRate: Double
    let rateCount: Int
    let speciality: String
    let url: String
    let pictures: [String]
    
    private enum CodingKeys: String, CodingKey {
        case id, name, address, city, zipcode, speciality, url
        case latitude = "gps_lat"
        case longitude = "gps_long"
        case currencyCode = "currency_code"
        case cardPrice = "card_price"
        case averageRate = "avg_rate"
        case rateCount = "rate_count"
        case pictures = "pics_diaporama"
        case tripAdvisorRateCount = "tripadvisor_rate_count"
        case tripAdvisorAverageRate = "tripadvisor_avg_rate"
    }
}
