//
//  GithubAuthenticatedAPI.swift
//  
//
//  Created by Dorian on 26/01/2023.
//

import Foundation
import Netswift

public extension Github.API {
    class Authenticated {
        private let performer: NetswiftNetworkPerformer
        private let configuration: Github.Configuration
        
        var token: String {
            configuration.base64EncodedToken
        }
        
        /// The currently authenticated user.
        let authenticatedUser: Github.API.Models.User
        
        
        internal init(
            configuration: Github.Configuration,
            performer: NetswiftNetworkPerformer = NetswiftPerformer()
        ) async throws {
            self.configuration = configuration
            self.performer = performer
            self.authenticatedUser = try await performer.perform(
                Authenticated.User.Endpoint.getAuthenticatedUser(token: configuration.base64EncodedToken)
            )
        }
        
        func perform<Endpoint: GithubAuthenticatedEndpoint>(
            _ endpoint: Endpoint,
            deadline: DispatchTime? = nil,
            _ handler: @escaping NetswiftHandler<Endpoint.Response>
        ) -> NetswiftTask? {
            return performer.perform(endpoint, deadline: deadline) { result in
                DispatchQueue.main.async {
                    handler(result)
                }
            }
        }
        
        func perform<Endpoint: GithubAuthenticatedEndpoint>(_ endpoint: Endpoint) async -> NetswiftResult<Endpoint.Response> {
            return await performer.perform(endpoint)
        }
    }
}

public extension Github.API.Authenticated {
    static func main(configuration: Github.Configuration) async throws -> Github.API.Authenticated {
        try await .init(configuration: configuration)
    }
    
    static func mock(configuration: Github.Configuration, performer: HTTPPerformer) async throws -> Github.API.Authenticated {
        try await .init(configuration: configuration, performer: NetswiftPerformer(requestPerformer: performer))
    }
}
