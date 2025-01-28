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

    func fetchMovies(endpoint: APIEndpoint) -> AnyPublisher<[Movie], Error> {
        guard let apiKey = apiKey else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }

        let url = URL(string: endpoint.urlString + "?api_key=\(apiKey)")!
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { data, response -> [Movie] in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                let movies = try JSONDecoder().decode([Movie].self, from: data)
                return movies
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}


