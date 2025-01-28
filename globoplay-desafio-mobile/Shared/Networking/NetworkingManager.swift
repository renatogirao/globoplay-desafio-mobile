//
//  NetworkingManager.swift
//  globoplay-desafio-mobile
//
//  Created by Renato Girão on 28/01/25.
//

import Foundation
import Combine

class NetworkingManager {
    
    private let apiKey = "YOUR_API_KEY"
    private var cancellables = Set<AnyCancellable>()
    
    func fetchMovies(endpoint: APIEndpoint) -> AnyPublisher<[Movie], Error> {
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
