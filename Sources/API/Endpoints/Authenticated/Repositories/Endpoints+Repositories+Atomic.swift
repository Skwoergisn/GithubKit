//
//  Endpoints+Repositories+Atomic.swift
//  
//
//  Created by Dorian on 27/01/2023.
//

import Foundation
import Netswift

extension Github.API.Authenticated.Repositories.Endpoints {
    struct Atomic: GithubAuthenticatedEndpoint {
        let token: String
        let request: Request
        
        enum Request {
            case get(owner: String, repo: String)
            case create(body: Body)
        }
        
        typealias Response = Github.API.Models.Repository
        
        var path: String? {
            switch request {
            case let .get(owner, repo): return "/repos/\(owner)/\(repo)"
            case .create: return "/user/repos"
            }
        }
        
        var method: NetswiftHTTPMethod {
            switch request {
            case .get: return .get
            case .create: return .post
            }
        }
        
        func body(encodedBy encoder: NetswiftEncoder?) throws -> Data? {
            switch request {
            case let .create(body):
                return try encoder?.encode(body)
                
            case .get:
                return nil
            }
        }
    }
}

extension Github.API.Authenticated.Repositories.Endpoints.Atomic {
    struct Body: Encodable {
        let name: String
        let description: String?
        let autoInit: Bool
        let `private`: Bool?
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(name, forKey: .name)
            try container.encode(description, forKey: .description)
            try container.encode(autoInit, forKey: .autoInit)
            try container.encode(`private`, forKey: .private)
        }
        
        enum CodingKeys: String, CodingKey {
            case name = "name"
            case description = "description"
            case autoInit = "auto_init"
            case `private` = "private"
        }
    }
}
