//
//  KeychainManager.swift
//  globoplay-desafio-mobile
//
//  Created by Renato Girão on 28/01/25.
//

import KeychainSwift

class KeychainManager {
    private let keychain = KeychainSwift()

    func saveAPIKey(apiKey: String) {
        keychain.set(apiKey, forKey: "api_key")
    }

    func saveToken(token: String) {
        keychain.set(token, forKey: "auth_token")
    }

    func getAPIKey() -> String? {
        return keychain.get("api_key")
    }

    func getToken() -> String? {
        return keychain.get("auth_token")
    }
}
