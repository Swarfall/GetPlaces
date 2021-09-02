//
//  NetworkClient.swift
//  Megakit
//
//  Created by Viacheslav Savitskyi on 31.08.2021.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

final class NetworkClient {
    func request(path: String,
                 method: HTTPMethod = .get,
                 urlParams: String? = nil,
                 completion: @escaping(Data) -> Void,
                 failure: @escaping(Error?) -> Void) {
        
        var newPath = path
        if let urlParams = urlParams {
            newPath.append(urlParams)
        }
        
        guard let url = URL(string: newPath) else {
            failure(CustomError.tryAgain)
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        let session = URLSession.shared
        
        session.dataTask(with: request) { data, responce, error in
            guard let data = data else {
                failure(error)
                return
            }
            
            if error == nil {
                completion(data)
            } else {
                failure(error)
            }
        }.resume()
    }
}
