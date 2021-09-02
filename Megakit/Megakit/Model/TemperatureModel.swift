//
//  TemperatureModel.swift
//  Megakit
//
//  Created by Viacheslav Savitskyi on 01.09.2021.
//

import Foundation

// MARK: - TemperatureModel
struct TemperatureModel: Codable {
    let main: Main
}

// MARK: - Main
struct Main: Codable {
    let temp: Double
}
