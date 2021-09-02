//
//  CityViewModel.swift
//  Megakit
//
//  Created by Viacheslav Savitskyi on 01.09.2021.
//

import Foundation

struct CityViewModel {
    let name: String
    let temperature: Double
    
    init(name: String, temperature: Double) {
        self.name = name
        self.temperature = temperature
    }
}
