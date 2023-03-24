//
//  Endpoints+Git.Trees.swift
//  
//
//  Created by Dorian on 27/01/2023.
//

import Foundation
import Netswift

extension Github.API.Authenticated.Git.Endpoints {
    struct Trees: GithubAuthenticatedEndpoint {
        let token: String
        let owner: String
        let repo: String
        let request: Request
        
        typealias Response = Github.API.Models.Tree
        
        enum Request {
            case root(branch: String)
            case create(body: Body)
        }
        
        var path: String? {
            let path = "/repos/\(owner)/\(repo)/git/trees"
            switch request {
            case let .root(branch): return path + "/\(branch)"
            case .create: return path
            }
        }
        
        var method: NetswiftHTTPMethod {
            switch request {
            case .create: return .post
            case .root: return .get
            }
        }
        
        func body(encodedBy encoder: NetswiftEncoder?) throws -> Data? {
            switch request {
            case let .create(body):
                return try encoder?.encode(body)
                
            case .root:
                return nil
            }
        }
    }
}

extension Github.API.Authenticated.Git.Endpoints.Trees {
    struct Body: Encodable {
        let baseTreeSHA: String
        let items: [Github.API.Models.Tree.Element]
        
        enum CodingKeys: String, CodingKey {
            case baseTreeSHA = "base_tree"
            case items = "tree"
        }
    }
}
