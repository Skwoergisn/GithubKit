//
//  File.swift
//  
//
//  Created by Dorian on 30/01/2023.
//

import Foundation

public extension Github.API.Models {
    /// The configuration for GitHub Pages for a repository.
    struct Page: Codable, Equatable {
        /// The process in which the Page will be built.
        public let buildType: BuildType?
        /// The Pages site's custom domain
        public let cname: String?
        /// Whether the Page has a custom 404 page.
        public let custom404: Bool
        /// The web address the Page can be accessed from.
        public let htmlURL: String?
        public let httpsCertificate: PagesHTTPSCertificate?
        /// Whether https is enabled on the domain
        public let httpsEnforced: Bool?
        /// The timestamp when a pending domain becomes unverified.
        public let pendingDomainUnverifiedAt: Date?
        /// The state if the domain is verified
        public let protectedDomainState: ProtectedDomainState?
        /// Whether the GitHub Pages site is publicly visible. If set to `true`, the site is
        /// accessible to anyone on the internet. If set to `false`, the site will only be accessible
        /// to users who have at least `read` access to the repository that published the site.
        public let pagePublic: Bool
        public let source: PagesSourceHash?
        /// The status of the most recent build of the Page.
        public let status: Status?
        /// The API address for accessing this Page resource.
        public let url: String
        
        enum CodingKeys: String, CodingKey {
            case buildType = "build_type"
            case cname = "cname"
            case custom404 = "custom_404"
            case htmlURL = "html_url"
            case httpsCertificate = "https_certificate"
            case httpsEnforced = "https_enforced"
            case pendingDomainUnverifiedAt = "pending_domain_unverified_at"
            case protectedDomainState = "protected_domain_state"
            case pagePublic = "public"
            case source = "source"
            case status = "status"
            case url = "url"
        }
        
        public init(buildType: BuildType?, cname: String?, custom404: Bool, htmlURL: String?, httpsCertificate: PagesHTTPSCertificate?, httpsEnforced: Bool?, pendingDomainUnverifiedAt: Date?, protectedDomainState: ProtectedDomainState?, pagePublic: Bool, source: PagesSourceHash?, status: Status?, url: String) {
            self.buildType = buildType
            self.cname = cname
            self.custom404 = custom404
            self.htmlURL = htmlURL
            self.httpsCertificate = httpsCertificate
            self.httpsEnforced = httpsEnforced
            self.pendingDomainUnverifiedAt = pendingDomainUnverifiedAt
            self.protectedDomainState = protectedDomainState
            self.pagePublic = pagePublic
            self.source = source
            self.status = status
            self.url = url
        }
        
        public enum BuildType: String, Codable, Equatable {
            case legacy = "legacy"
            case workflow = "workflow"
        }
        
        // MARK: - PagesHTTPSCertificate
        public struct PagesHTTPSCertificate: Codable, Equatable {
            public let description: String
            /// Array of the domain set and its alternate name (if it is configured)
            public let domains: [String]
            public let expiresAt: String?
            public let state: State
            
            enum CodingKeys: String, CodingKey {
                case description = "description"
                case domains = "domains"
                case expiresAt = "expires_at"
                case state = "state"
            }
            
            public init(description: String, domains: [String], expiresAt: String?, state: State) {
                self.description = description
                self.domains = domains
                self.expiresAt = expiresAt
                self.state = state
            }
        }
        
        public enum State: String, Codable, Equatable {
            case approved = "approved"
            case authorizationCreated = "authorization_created"
            case authorizationPending = "authorization_pending"
            case authorizationRevoked = "authorization_revoked"
            case authorized = "authorized"
            case badAuthz = "bad_authz"
            case destroyPending = "destroy_pending"
            case dnsChanged = "dns_changed"
            case errored = "errored"
            case issued = "issued"
            case new = "new"
            case uploaded = "uploaded"
        }
        
        public enum ProtectedDomainState: String, Codable, Equatable {
            case pending = "pending"
            case unverified = "unverified"
            case verified = "verified"
        }
        
        // MARK: - PagesSourceHash
        public struct PagesSourceHash: Codable, Equatable {
            public let branch: String
            public let path: String
            
            enum CodingKeys: String, CodingKey {
                case branch = "branch"
                case path = "path"
            }
            
            public init(branch: String, path: String) {
                self.branch = branch
                self.path = path
            }
        }
        
        public enum Status: String, Codable, Equatable {
            case building = "building"
            case built = "built"
            case errored = "errored"
        }
    }
}
