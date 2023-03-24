//
//  GithubAPI.swift
//  
//
//  Created by Dorian on 15/01/2023.
//

import Foundation
import Netswift

/// This app's networking layer.
public extension Github.API {
    class Public {
        
        private let performer: NetswiftNetworkPerformer
        
        internal init(performer: NetswiftNetworkPerformer = NetswiftPerformer()) {
            self.performer = performer
        }
        
        func perform<Endpoint: GithubEndpoint>(_ endpoint: Endpoint,
                                               deadline: DispatchTime? = nil,
                                               _ handler: @escaping NetswiftHandler<Endpoint.Response>) -> NetswiftTask? {
            return performer.perform(endpoint, deadline: deadline) { result in
                DispatchQueue.main.async {
                    handler(result)
                }
            }
        }
        
        @MainActor
        func perform<Endpoint: GithubEndpoint>(_ endpoint: Endpoint) async -> NetswiftResult<Endpoint.Response> {
            return await performer.perform(endpoint)
        }
    }
}

public extension Github.API.Public {
    
    /// The default configuration for the API routes & endpoints.
    static let main: Github.API.Public = {
        Github.API.Public()
    }()
    
    /// A mock implementation & configuration for the API routes & endpoints.
    ///
    /// - returns: An API which uses the given http performer.
    static func mock(_ httpPerformer: NetswiftHTTPPerformer) -> Github.API.Public {
        Github.API.Public(performer: NetswiftPerformer(requestPerformer: httpPerformer))
    }
}
