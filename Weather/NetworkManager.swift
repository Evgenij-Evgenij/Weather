//
//  NetworkManager.swift
//  Weather
//
//  Created by Евгений Воронов on 24.01.2023.
//

import Foundation

class NetworkManager {
    static func fetchData( urlString: String, complition: @escaping (Result<ModelWeather, NetworkError>)-> Void) {
        guard let url = URL(string: urlString) else {
            complition(.failure(.error(err: "Invalid URL")))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil else {
                print(String(describing: error))
                complition(.failure(NetworkError.error(err: error!.localizedDescription)))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                complition(.failure(.invalidResponse))
                return
            }
             
            guard let data = data else {
                complition(.failure(.invalidData))
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(ModelWeather.self, from: data)
                complition(.success(decodedData))
            } catch let err  {
                print("\(err)")
                complition(.failure(.errorDecode(err: err.localizedDescription)))
            }
        }
        .resume()
    }
}

enum NetworkError: Error {
    case invalidResponse
    case invalidData
    case error (err: String)
    case errorDecode (err: String)
}
