//
//  CityModel.swift
//  Megakit
//
//  Created by Viacheslav Savitskyi on 31.08.2021.
//

import Foundation

// MARK: - CityModel
struct CityModel: Codable {
    let results: [Result]
}

// MARK: - Result
struct Result: Codable {
    let formattedAddress: String
    let geometry: Geometry
    
    enum CodingKeys: String, CodingKey {
        case formattedAddress = "formatted_address"
        case geometry
    }
}

// MARK: - Geometry
struct Geometry: Codable {
    let location: Location
    
    enum CodingKeys: String, CodingKey {
        case location
    }
}

// MARK: - Location
struct Location: Codable {
    let lat, lng: Double
}
