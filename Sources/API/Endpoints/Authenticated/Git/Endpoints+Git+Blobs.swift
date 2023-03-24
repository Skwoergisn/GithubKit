//
//  Endpoints+Git+Blobs.swift
//  
//
//  Created by Dorian on 27/01/2023.
//

import Foundation
import Netswift

extension Github.API.Authenticated.Git.Endpoints {
    struct Blobs: GithubAuthenticatedEndpoint {
        let token: String
        let owner: String
        let repo: String
        let request: Request
        
        typealias Response = Github.API.Models.Blob
        
        enum Request {
            case create(contents: Github.API.Models.Blob.Contents)
        }
        
        var path: String? {
            let path = "/repos/\(owner)/\(repo)/git/blobs"
            switch request {
            case .create: return path
            }
        }
        
        var method: NetswiftHTTPMethod {
            switch request {
            case .create: return .post
            }
        }
        
        func body(encodedBy encoder: NetswiftEncoder?) throws -> Data? {
            switch request {
            case let .create(contents):
                return try encoder?.encode(contents)
            }
        }
        
    }
}
