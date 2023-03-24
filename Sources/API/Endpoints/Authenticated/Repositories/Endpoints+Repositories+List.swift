//
//  Endpoints+Repositories+List.swift
//  
//
//  Created by Dorian on 27/01/2023.
//

import Foundation

extension Github.API.Authenticated.Repositories.Endpoints {
    enum List: GithubAuthenticatedEndpoint {
        case authenticatedUserRepositories(token: String,
                                           parameters: Github.API.QueryParameters? = nil)
        
        public typealias Response = [Github.API.Models.Repository]
        
        var token: String {
            switch self {
            case let .authenticatedUserRepositories(token, _):
                return token
            }
        }
        
        public var path: String? {
            switch self {
            case .authenticatedUserRepositories: return "/user/repos"
            }
        }
        
        public var query: String? {
            switch self {
            case let .authenticatedUserRepositories(_, parameters):
                return parameters?.query
            }
        }
    }
}
