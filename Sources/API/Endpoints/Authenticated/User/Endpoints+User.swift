//
//  Endpoints+User.swift
//  
//
//  Created by Dorian on 27/01/2023.
//

import Foundation

public extension Github.API.Authenticated {
    /// User Endpoints
    struct User {
        let api: Github.API.Authenticated
        
        public func getAuthenticatedUser() async throws -> Github.API.Models.User {
            try await api.perform(Endpoint.getAuthenticatedUser(token: api.token)).throwingValue()
        }
    }
}

public extension Github.API.Authenticated {
    /// User endpoints
    var user: User {
        .init(api: self)
    }
}

extension Github.API.Authenticated.User {
    enum Endpoint: GithubAuthenticatedEndpoint {
        case getAuthenticatedUser(token: String)
        
        typealias Response = Github.API.Models.User
        
        var token: String {
            switch self {
            case let .getAuthenticatedUser(token):
                return token
            }
        }
        
        var path: String? {
            switch self {
            case .getAuthenticatedUser: return "/user"
            }
        }
    }
}
