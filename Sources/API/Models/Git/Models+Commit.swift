//
//  File.swift
//  
//
//  Created by Dorian on 28/01/2023.
//

import Foundation



public extension Github.API.Models {
    /// Low-level Git commit operations within a repository
    struct Commit: Codable, Equatable {
        /// Identifying information for the git-user
        public let author: Author?
        /// Identifying information for the git-user
        public let committer: Author?
        public let htmlURL: String
        /// Message describing the purpose of the commit
        public let message: String
        public let nodeID: String
        public let parents: [Parent]
        /// SHA for the commit
        public let sha: String
        public let tree: Tree
        public let url: String
        public let verification: Verification
        
        enum CodingKeys: String, CodingKey {
            case author, committer
            case htmlURL = "html_url"
            case message
            case nodeID = "node_id"
            case parents, sha, tree, url, verification
        }
        
        public init(author: Author, committer: Author, htmlURL: String, message: String, nodeID: String, parents: [Parent], sha: String, tree: Tree, url: String, verification: Verification) {
            self.author = author
            self.committer = committer
            self.htmlURL = htmlURL
            self.message = message
            self.nodeID = nodeID
            self.parents = parents
            self.sha = sha
            self.tree = tree
            self.url = url
            self.verification = verification
        }
        
        /// Identifying information for the git-user
        // MARK: - Author
        public struct Author: Codable, Equatable {
            /// Timestamp of the commit
            public let date: Date
            /// Git email address of the user
            public let email: String
            /// Name of the git user
            public let name: String
            
            public init(date: Date, email: String, name: String) {
                self.date = date
                self.email = email
                self.name = name
            }
        }
        
        // MARK: - Parent
        public struct Parent: Codable, Equatable {
            public let htmlURL: String
            /// SHA for the commit
            public let sha: String
            public let url: String
            
            enum CodingKeys: String, CodingKey {
                case htmlURL = "html_url"
                case sha, url
            }
            
            public init(htmlURL: String, sha: String, url: String) {
                self.htmlURL = htmlURL
                self.sha = sha
                self.url = url
            }
        }
        
        // MARK: - Tree
        public struct Tree: Codable, Equatable {
            /// SHA for the commit
            public let sha: String
            public let url: String
            
            public init(sha: String, url: String) {
                self.sha = sha
                self.url = url
            }
        }
        
        // MARK: - Verification
        public struct Verification: Codable, Equatable {
            public let payload: String?
            public let reason: String
            public let signature: String?
            public let verified: Bool
            
            public init(payload: String?, reason: String, signature: String?, verified: Bool) {
                self.payload = payload
                self.reason = reason
                self.signature = signature
                self.verified = verified
            }
        }
    }
}
