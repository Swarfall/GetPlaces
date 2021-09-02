//
//  Requests.swift
//  Megakit
//
//  Created by Viacheslav Savitskyi on 31.08.2021.
//

import Foundation

final class Requests {
    private static var networkClient = NetworkClient()
    
    static func getPlaces(lat: String,
                          long: String,
                          completion: ((CityModel) -> Void)?,
                          failure: ((Error?) -> Void)?) {
        
        networkClient.request(path: RequestPath.baseGoogleURL.rawValue,
                              urlParams: "?latlng=\(lat),\(long)&key=\(Constant.googleKey)") { data in
            do {
                let result = try JSONDecoder().decode(CityModel.self, from: data)
                completion?(result)
            } catch let error {
                failure?(error)
            }
        } failure: { error in
            failure?(error)
        }
    }
    
    static func getTemperature(lat: String,
                               long: String,
                               completion: ((TemperatureModel?) -> Void)?,
                               failure: ((Error?) -> Void)?) {
        
        networkClient.request(path: RequestPath.baseOpenweathermapURL.rawValue,
                              urlParams: "?lat=\(lat)&lon=\(long)&appid=\(Constant.openweathermapKey)") { data in
            
            do {
                let result = try JSONDecoder().decode(TemperatureModel?.self, from: data)
                completion?(result)
            } catch let error {
                failure?(error)
            }
        } failure: { error in
            failure?(error)
        }
    }
}
