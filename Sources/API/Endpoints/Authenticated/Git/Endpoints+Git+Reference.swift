//
//  Endpoints+Git+Reference.swift
//  
//
//  Created by Dorian on 28/01/2023.
//

import Foundation
import Netswift

extension Github.API.Authenticated.Git.Endpoints {
    struct Reference: GithubAuthenticatedEndpoint {
        let token: String
        let owner: String
        let repo: String
        let branch: String
        
        let request: Request
        
        enum Request {
            case head
            case update(sha: String)
        }
        
        typealias Response = Github.API.Models.Reference
        
        var method: NetswiftHTTPMethod {
            switch request {
            case .head:
                return .get
            case .update:
                return .patch
            }
        }
        
        var path: String? {
            switch request {
            case .update, .head:
                return "/repos/\(owner)/\(repo)/git/refs/heads/\(branch)"
            }
        }
        
        func body(encodedBy encoder: NetswiftEncoder?) throws -> Data? {
            switch request {
            case .head:
                return nil
            case let .update(sha):
                return try encoder?.encode(Body(sha: sha))
            }
        }
    }
}

extension Github.API.Authenticated.Git.Endpoints.Reference {
    struct Body: Codable {
        let sha: String
    }
}
