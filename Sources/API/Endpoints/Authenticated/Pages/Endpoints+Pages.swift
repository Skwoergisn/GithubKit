//
//  Endpoints+Pages.swift
//  
//
//  Created by Dorian on 30/01/2023.
//

import Foundation
import Netswift

public extension Github.API.Authenticated {
    /**
     Github Pages Endpoints
     */
    struct Pages {
        let api: Github.API.Authenticated
        
        /**
         Fetches the configuration of a Github Pages site.
         - parameters:
            - repository: The repository for which to update the Pages configuration
            - owner: The owner of the repository. If `nil`, uses the currently authenticated user.
         */
        public func getConfiguration(
            on repository: Github.API.Models.Repository,
            of owner: Github.API.Models.User? = nil
        ) async throws -> Github.API.Models.Page {
            try await api.perform(
                Endpoint(
                    token: api.token,
                    owner: (owner ?? api.authenticatedUser).login,
                    repo: repository.name,
                    request: .get
                )
            ).throwingValue()
        }
        
        /**
         Configures a GitHub Pages site.
         
         For more information, see ["About GitHub Pages"](https://docs.github.com/github/working-with-github-pages/about-github-pages).

         - note: To use this endpoint, you must be a repository administrator, maintainer, or have the 'manage GitHub Pages settings' permission. A token with the repo scope or Pages write permission is required. GitHub Apps must have the administration:write and pages:write permissions.
         - parameters:
            - repository: The repository for which to update the Pages configuration
            - buildType: The process by which the GitHub Pages site will be built. `workflow` means that the site is built by a custom GitHub Actions workflow. `legacy` means that the site is built by GitHub when changes are pushed to a specific branch.
            - source: The source branch and directory used to publish your Pages site
         */
        public func create(
            for repository: Github.API.Models.Repository,
            buildType: BuildType = .legacy,
            source: Source = .init(branch: "main", path: .root)
        ) async throws -> Github.API.Models.Page {
            try await api.perform(
                Endpoint(
                    token: api.token,
                    owner: api.authenticatedUser.login,
                    repo: repository.name,
                    request: .create(
                        body: .init(
                            buildType: buildType,
                            source: source
                        )
                    )
                )
            ).throwingValue()
        }
        
        /**
         Updates information for a GitHub Pages site.
         
         For more information, see ["About GitHub Pages"](https://docs.github.com/github/working-with-github-pages/about-github-pages).
         
         - note: To use this endpoint, you must be a repository administrator, maintainer, or have the 'manage GitHub Pages settings' permission. A token with the repo scope or Pages write permission is required. GitHub Apps must have the administration:write and pages:write permissions.
         
         - parameters:
            - repository: The repository for which to update the Pages configuration
            - buildType: The process by which the GitHub Pages site will be built. `workflow` means that the site is built by a custom GitHub Actions workflow. `legacy` means that the site is built by GitHub when changes are pushed to a specific branch.
            - source: The source branch and directory used to publish your Pages site
            - cname: Specifies a custom domain for the repository. Sending a `nil` value will remove the custom domain. For more info about custom domains, see [using a custom domain with GitHub Pages](https://docs.github.com/articles/using-a-custom-domain-with-github-pages/).
            - enforceHTTPS: Whether HTTPS should be enforced for the repository.
         */
        public func updateConfiguration(
            on repository: Github.API.Models.Repository,
            buildType: BuildType? = nil,
            source: Source? = nil,
            cname: String? = nil,
            enforceHTTPS: Bool? = nil
        ) async throws {
            _ = try await api.perform(
                Endpoint(
                    token: api.token,
                    owner: api.authenticatedUser.login,
                    repo: repository.name,
                    request: .update(
                        body: .init(
                            cname: cname,
                            httpsEnforced: enforceHTTPS,
                            buildType: buildType,
                            source: source
                        )
                    )
                )
            ).throwingValue()
        }
    }
}

public extension Github.API.Authenticated {
    /// Github Pages endpoints
    var pages: Pages {
        .init(api: self)
    }
}

public extension Github.API.Authenticated.Pages {
    /**
     The process by which the GitHub Pages site will be built. workflow means that the site is built by a custom GitHub Actions workflow. legacy means that the site is built by GitHub when changes are pushed to a specific branch.
     */
    enum BuildType: String, Encodable {
        case legacy = "legacy"
        case workflow = "workflow"
    }
    
    /**
     The source branch and directory used to publish your Pages site
     */
    struct Source: Encodable {
        /// The repository branch used to publish your site's source files.
        public let branch: String
        /// The repository directory that includes the source files for the Pages site.
        /// Allowed paths are `/` or `/docs`.
        public let path: Path
        
        public init(branch: String, path: Path) {
            self.branch = branch
            self.path = path
        }
        
        public enum Path: String, Encodable {
            case root = "/"
            case docs = "/docs"
        }
    }
}

extension Github.API.Authenticated.Pages {
    struct Endpoint: GithubAuthenticatedEndpoint {
        let token: String
        let owner: String
        let repo: String
        let request: Request
        
        enum Request {
            case get
            case create(body: Github.API.Authenticated.Pages.Endpoint.Body.Create)
            case update(body: Github.API.Authenticated.Pages.Endpoint.Body.Update)
        }
        
        public typealias Response = Github.API.Models.Page
        
        public var path: String? {
            switch request {
            case .get, .create, .update:
                return "/repos/\(owner)/\(repo)/pages"
            }
        }
        
        public var method: NetswiftHTTPMethod {
            switch request {
            case .get:
                return .get
            case .create:
                return .post
            case .update:
                return .put
            }
        }
        
        public func body(encodedBy encoder: NetswiftEncoder?) throws -> Data? {
            switch request {
            case let  .create(body):
                return try encoder?.encode(body)
                
            case let .update(body):
                return try encoder?.encode(body)
                
            case .get:
                return nil
            }
        }
    }
}

extension Github.API.Authenticated.Pages.Endpoint {
    enum Body {
        struct Create: Encodable {
            let buildType: Github.API.Authenticated.Pages.BuildType
            let source: Github.API.Authenticated.Pages.Source
        }
        
        struct Update: Encodable {
            @NullEncodable private(set) var cname: String?
            let httpsEnforced: Bool?
            let buildType: Github.API.Authenticated.Pages.BuildType?
            let source: Github.API.Authenticated.Pages.Source?
        }
    }
}
