//
//  CityViewModel.swift
//  Megakit
//
//  Created by Viacheslav Savitskyi on 01.09.2021.
//

import Foundation

struct CityViewModel {
    let name: String
    var temperature: Double?
    
    let lat: Double
    let long: Double
    
    init(name: String, lat: Double, long: Double) {
        self.name = name
        self.lat = lat
        self.long = long
    }
}
