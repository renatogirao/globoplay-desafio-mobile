//
//  NetworkError.swift
//  globoplay-desafio-mobile
//
//  Created by Renato Girão on 29/01/25.
//

import Foundation

enum NetworkError: Error {
    case badURL
    case badServerResponse(statusCode: Int)
    case decodingError(Error)
    case unknownError
    
    var localizedDescription: String {
        switch self {
        case .badURL:
            return "URL Inválida."
        case .badServerResponse(let statusCode):
            return "Servidor retornou uma resposta inválida (código de status: \(statusCode))."
        case .decodingError(let error):
            return "Falha ao decodificar a resposta: \(error.localizedDescription)"
        case .unknownError:
            return "Ocorreu um erro desconhecido."
        }
    }
}
