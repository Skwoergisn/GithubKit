//
//  Endpoints+Repositories.swift
//  
//
//  Created by Dorian on 26/01/2023.
//

import Foundation
import Netswift

public extension Github.API.Authenticated {
    struct Repositories {
        let api: Github.API.Authenticated
        
        /**
         Returns all repositories for the currently authenticated user.
         
         - parameter parameters: The query parameters to use for this request. This endpoint is paginated and returns 30 items per page by default.
         */
        public func userRepositories(_ parameters: Github.API.QueryParameters? = nil) async throws -> [Github.API.Models.Repository] {
            try await api.perform(
                Endpoints.List.authenticatedUserRepositories(
                    token: api.token,
                    parameters: parameters
                )
            ).throwingValue()
        }
        
        /**
         Searches for and returns a repository based on its name.
         
         - parameters:
            - owner: The owner of the repository. If `nil`, uses the currently authenticated user.
            - name: The name of the repository.
         
         - returns: A fully-qualified Repository object.
         */
        public func repository(for owner: Github.API.Models.User? = nil, name: String) async throws -> Github.API.Models.Repository {
            return try await repository(
                owner: owner?.login ?? api.authenticatedUser.login,
                name: name
            )
        }
        
        /**
         Searches for and returns a repository based on its name.
         
         - parameters:
            - owner: The name of the owner of the repository.
            - name: The name of the repository.
         
         - returns: A fully-qualified Repository object.
         */
        public func repository(owner: String, name: String) async throws -> Github.API.Models.Repository {
            return try await api.perform(
                Endpoints.Atomic(
                    token: api.token,
                    request: .get(owner: owner, repo: name)
                )
            ).throwingValue()
        }
        
        /**
         Creates a new repository for the authenticated user.
         
         - parameters:
            - name: The name of the new repository.
            - description: A description for this repository. Defaults to `nil`.
            - autoInit: Whether or not this repository should be created with a README. Defaults to `false`.
            - private: Whether or not this repository should be private. Defaults to `false`.
         - important: If `autoInit` is set to `false`, it will not be possible to create commits for this repository through the Github API, until at least a single file/commit is created. You can use the `Contents.create(_:)` endpoint to do so.
         */
        public func create(
            name: String,
            description: String? = nil,
            autoInit: Bool = false,
            private: Bool = false
        ) async throws -> Github.API.Models.Repository {
            return try await api.perform(
                Endpoints.Atomic(token: api.token,
                                 request: .create(
                                    body: .init(name: name,
                                                description: description,
                                                autoInit: autoInit,
                                                private: `private`)
                                 )
                                )
            ).throwingValue()
        }
    }
}

public extension Github.API.Authenticated {
    /// Repositories endpoints
    var repositories: Repositories {
        .init(api: self)
    }
}

extension Github.API.Authenticated.Repositories {
    enum Endpoints {}
    
    public var contents: Contents {
        .init(api: api)
    }
}
