//
//  Endpoints+Repositories+Contents.swift
//  
//
//  Created by Dorian on 28/01/2023.
//

import Foundation
import Netswift

public extension Github.API.Authenticated.Repositories {
    struct Contents {
        let api: Github.API.Authenticated
        
        public func file(
            path: String,
            in repository: Github.API.Models.Repository
        ) async throws -> Data {
            try await api.perform(
                Endpoint(token: api.token,
                         owner: repository.owner.login,
                         repo: repository.name,
                         request: .file(name: path))
            ).throwingValue()
        }
        
        public func file(
            path: String,
            in repository: Github.API.Models.Repository
        ) async throws -> String {
            guard let string = String(
                data: try await file(path: path, in: repository),
                encoding: .utf8
            ) else {
                throw DecodingError.dataCorrupted(
                    .init(codingPath: [],
                          debugDescription: "Could not init String from response"))
            }
            
            return string
        }
    }
}

extension Github.API.Authenticated.Repositories.Contents {
    struct Endpoint: GithubAuthenticatedEndpoint {
        let token: String
        let owner: String
        let repo: String
        let request: Request
        
        enum Request {
            case file(name: String)
        }
        
        typealias Response = Data
        
        var path: String? {
            switch request {
            case let .file(path):
                return "/repos/\(owner)/\(repo)/contents/\(path)"
            }
        }
        
        var headers: NetswiftHeaders {
            var headers = defaultAuthenticatedHeaders
            
            switch request {
            case .file:
                headers.accept = .github(.raw)
            }
            
            return headers
        }
        
        func deserialise(_ incomingData: Data) -> NetswiftResult<Data> {
            .success(incomingData)
        }
    }
}
