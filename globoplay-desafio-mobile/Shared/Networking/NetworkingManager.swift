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
    
    private let keychain = KeychainSwift()
    private var cancellables = Set<AnyCancellable>()
    static let shared = NetworkingManager()
    
    func storeTokenInKeychain(_ token: String) {
        keychain.set(token, forKey: "api_key")
    }
    
    func getData(from endpoint: APIEndpoint, movieId: Int? = nil, showAlert: @escaping (String) -> Void) -> AnyPublisher<MovieResponse, Error> {
        var urlString = endpoint.urlString
        
        if let movieId = movieId {
            urlString = urlString.replacingOccurrences(of: "{movieId}", with: "\(movieId)")
        }
        
        guard let apiKey = keychain.get("api_key") else {
            let errorMessage = NetworkError.unknownError.localizedDescription
            print("Erro: \(errorMessage)\n")
            showAlert(errorMessage)
            return Fail(error: NetworkError.unknownError).eraseToAnyPublisher()
        }
        
        guard let url = URL(string: "\(urlString)?api_key=\(apiKey)") else {
            let errorMessage = NetworkError.badURL.localizedDescription
            print("Erro: \(errorMessage)\n")
            showAlert(errorMessage)
            return Fail(error: NetworkError.badURL).eraseToAnyPublisher()
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        
        print("URL final chamada: \(urlRequest.url?.absoluteString ?? "")")
        
        let publisher = URLSession.shared.dataTaskPublisher(for: urlRequest)
            .tryMap { data, response -> MovieResponse in
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw NetworkError.badServerResponse(statusCode: -1)
                }
                
                guard httpResponse.statusCode == 200 else {
                    print("Erro: Resposta do servidor com status code \(httpResponse.statusCode)\n")
                    throw NetworkError.badServerResponse(statusCode: httpResponse.statusCode)
                }
                
                do {
                    let decoder = JSONDecoder()
                    let movieResponse = try decoder.decode(MovieResponse.self, from: data)
                    return movieResponse
                } catch {
                    print("Erro de decodificação: \(error.localizedDescription)\n")
                    throw NetworkError.decodingError(error)
                }
            }
            .receive(on: DispatchQueue.main)
        
        publisher.sink(receiveCompletion: { completion in
            switch completion {
            case .finished:
                print("\nRequisição finalizada com sucesso.\n")
            case .failure(let error):
                if let networkError = error as? NetworkError {
                    print("Erro de rede: \(networkError.localizedDescription)\n\n")
                    showAlert(networkError.localizedDescription)
                } else {
                    print("Erro desconhecido: \(error.localizedDescription)\n\n")
                    showAlert(error.localizedDescription)
                }
            }
        }, receiveValue: { movieResponse in
            print("Dados recebidos: \(movieResponse)\n\n")
        })
        .store(in: &cancellables)
        
        return publisher.eraseToAnyPublisher()
    }
    
    func getMovieDetails(movieId: Int) -> AnyPublisher<MovieDetails, Error> {
        print("Iniciando requisição para detalhes do filme com ID: \(movieId)\n\n")
        
        let endpoint = APIEndpoint.movieDetail
        guard let apiKey = keychain.get("api_key") else {
            let errorMessage = NetworkError.unknownError.localizedDescription
            print("Erro: \(errorMessage)\n\n")
            return Fail(error: NetworkError.unknownError).eraseToAnyPublisher()
        }
        
        guard let url = URL(string: "\(endpoint.urlString)\(movieId)?api_key=\(apiKey)") else {
            let errorMessage = NetworkError.badURL.localizedDescription
            print("Erro: \(errorMessage)\n\n")
            return Fail(error: NetworkError.badURL).eraseToAnyPublisher()
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        print("Requisição configurada para o filme com ID: \(movieId)\n\n")
        print("Requisição configurada para a URL: \(urlRequest)\n\n")
        
        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .tryMap { data, response -> MovieDetails in
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw NetworkError.badServerResponse(statusCode: -1)
                }
                
                guard httpResponse.statusCode == 200 else {
                    print("Erro: Resposta do servidor com status code \(httpResponse.statusCode)\n\n")
                    throw NetworkError.badServerResponse(statusCode: httpResponse.statusCode)
                }
                
                do {
                    let decoder = JSONDecoder()
                    let movieDetails = try decoder.decode(MovieDetails.self, from: data)
                    print("Detalhes do filme decodificados com sucesso\n")
                    return movieDetails
                } catch {
                    print("Erro de decodificação dos detalhes do filme: \(error.localizedDescription)\n")
                    throw NetworkError.decodingError(error)
                }
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
