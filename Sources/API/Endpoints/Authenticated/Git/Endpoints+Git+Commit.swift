//
//  Endpoints+Git+Commit.swift
//  
//
//  Created by Dorian on 28/01/2023.
//

import Foundation
import Netswift

extension Github.API.Authenticated.Git.Endpoints {
    struct Commit: GithubAuthenticatedEndpoint {
        let token: String
        let owner: String
        let repo: String
        let request: Request
        
        enum Request {
            case get(reference: String)
            case create(body: Body)
        }
        
        typealias Response = Github.API.Models.Commit
        
        var path: String? {
            let path = "/repos/\(owner)/\(repo)/git/commits"
            switch request {
            case let .get(ref):
                return path + "\(ref)"
                
            case .create:
                return path
            }
        }
        
        var method: NetswiftHTTPMethod {
            switch request {
            case .create: return .post
            case .get: return .get
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

extension Github.API.Authenticated.Git.Endpoints.Commit {
    struct Body: Encodable {
        let treeSHA: String
        let message: String
        let parentCommitsSHAs: [String]
        
        enum CodingKeys: String, CodingKey {
            case treeSHA = "tree"
            case message = "message"
            case parentCommitsSHAs = "parents"
        }
    }
}
