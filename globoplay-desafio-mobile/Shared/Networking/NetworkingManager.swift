//
//  NetworkingManager.swift
//  globoplay-desafio-mobile
//
//  Created by Renato Girão on 28/01/25.
//

import Foundation
import Combine
import KeychainSwift

class NetworkingManager {
    private var cancellables = Set<AnyCancellable>()
    private let keychainManager = KeychainManager()

    private var apiKey: String? {
        return keychainManager.getAPIKey()
    }
    
    private var token: String? {
        return keychainManager.getToken()
    }
    
    func getData<T: Decodable>(from endpoint: APIEndpoint, type: T.Type) -> AnyPublisher<T, Error> {
        guard let apiKey = apiKey else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        let urlString = endpoint.urlString + "?api_key=\(apiKey)"
        guard let url = URL(string: urlString) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { data, response -> T in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                let decoder = JSONDecoder()
                return try decoder.decode(T.self, from: data)
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func getMovieDetails(movieId: Int) -> AnyPublisher<MovieDetail, Error> {
            guard let apiKey = apiKey else {
                return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
            }
            
            let urlString = "https://api.themoviedb.org/3/movie/\(movieId)?api_key=\(apiKey)"
            guard let url = URL(string: urlString) else {
                return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
            }
            
            return URLSession.shared.dataTaskPublisher(for: url)
                .tryMap { data, response -> MovieDetail in
                    guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                        throw URLError(.badServerResponse)
                    }
                    let decoder = JSONDecoder()
                    return try decoder.decode(MovieDetail.self, from: data)
                }
                .receive(on: DispatchQueue.main)
                .eraseToAnyPublisher()
        }
    }
}



