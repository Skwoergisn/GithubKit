//
//  Github+RequestBuilder.swift
//  
//
//  Created by Dorian on 15/01/2023.
//

import Foundation

extension Github.Configuration {
    struct RequestBuilder {
        let baseURL: URL
        let redirectURL: URL
        let queryItems: QueryItems
        let webviewRequest: URLRequest
        
        public init(clientID: String, clientSecret: String, baseURL: URL, redirectURL: URL) {
            let queryItems: QueryItems = .init(clientID: clientID, clientSecret: clientSecret, redirectURI: redirectURL.absoluteString)
            self.queryItems = queryItems
            self.baseURL = baseURL
            self.redirectURL = redirectURL
            self.webviewRequest = .init(url: baseURL
                .appending(path: Path.code)
                .appending(queryItems: queryItems.webview)
            )
        }
        
        private enum Path {
            static let code = "authorize"
            static let token = "access_token"
        }
        
        struct QueryItems {
            
            init(clientID: String, clientSecret: String, redirectURI: String) {
                self.clientID = .init(name: "client_id", value: clientID)
                self.clientSecret = .init(name: "client_secret", value: clientSecret)
                self.redirectURI = .init(name: "redirect_uri", value: redirectURI)
            }
            
            let clientID: URLQueryItem
            let clientSecret: URLQueryItem
            let redirectURI: URLQueryItem
            
            func code(_ code: String) -> URLQueryItem {
                .init(name: "code", value: code)
            }
            let scope: URLQueryItem = .init(name: "scope", value: "repo,repo_deployment")
            let state: URLQueryItem = .init(name: "state", value: UUID().uuidString)
            
            var webview: [URLQueryItem] {
                [
                    clientID,
                    scope,
                    redirectURI,
                    state
                ]
            }
            
            func token(withAccessCode code: String) -> [URLQueryItem] {
                [
                    clientID,
                    clientSecret,
                    self.code(code),
                ]
            }
        }
        
        func tokenURLRequest(withAccessCode code: String) -> URLRequest {
            let url = baseURL
                .appending(path: Path.token)
                .appending(queryItems: queryItems.token(withAccessCode: code))
            var request = URLRequest(url: url)
            request.setValue("application/json", forHTTPHeaderField: "accept")
            return request
        }
        
        func getOAuthToken(fromAccessCode code: String) async throws -> Github.Configuration {
            let decoder = JSONDecoder()
            if let data = UserDefaults().data(forKey: "config") {
                return try decoder.decode(Github.Configuration.self, from: data)
            }
            
            let (data, _) = try await URLSession.shared.data(for: tokenURLRequest(withAccessCode: code))
            let config = try decoder.decode(Github.Configuration.self, from: data)
            let encoder = JSONEncoder()
            UserDefaults().set(try encoder.encode(config), forKey: "config")
            return config
        }
    }
}
