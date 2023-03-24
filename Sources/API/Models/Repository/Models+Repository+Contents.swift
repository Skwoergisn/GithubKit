//
//  File.swift
//  
//
//  Created by Dorian on 28/01/2023.
//

import Foundation

public extension Github.API.Models.Repository {
    /// Content Tree
    struct Contents: Codable, Equatable {
        public let links: Links
        public let downloadURL: String?
        public let entries: [Entry]?
        public let gitURL, htmlURL: String?
        public let name, path, sha: String
        public let size: Int
        public let type, url: String
        public let contents: Github.API.Models.Blob.Contents?
        
        enum CodingKeys: String, CodingKey {
            case links = "_links"
            case downloadURL = "download_url"
            case entries
            case gitURL = "git_url"
            case htmlURL = "html_url"
            case name, path, sha, size, type, url
        }
        
        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.links = try container.decode(Links.self, forKey: .links)
            self.contents = try .init(from: decoder)
            self.downloadURL = try container.decodeIfPresent(String.self, forKey: .downloadURL)
            self.entries = try container.decode([Entry].self, forKey: .entries)
            self.gitURL = try container.decodeIfPresent(String.self, forKey: .gitURL)
            self.htmlURL = try container.decodeIfPresent(String.self, forKey: .htmlURL)
            self.name = try container.decode(String.self, forKey: .name)
            self.path = try container.decode(String.self, forKey: .path)
            self.sha = try container.decode(String.self, forKey: .sha)
            self.size = try container.decode(Int.self, forKey: .size)
            self.type = try container.decode(String.self, forKey: .type)
            self.url = try container.decode(String.self, forKey: .url)
        }
        
        public init(links: Links, downloadURL: String?, entries: [Entry]?, gitURL: String?, htmlURL: String?, name: String, path: String, sha: String, size: Int, type: String, url: String, contents: Github.API.Models.Blob.Contents?) {
            self.links = links
            self.downloadURL = downloadURL
            self.entries = entries
            self.gitURL = gitURL
            self.htmlURL = htmlURL
            self.name = name
            self.path = path
            self.sha = sha
            self.size = size
            self.type = type
            self.url = url
            self.contents = contents
        }
        
        // MARK: - Entry
        public struct Entry: Codable, Equatable {
            public let links: Links
            public let content: String?
            public let downloadURL, gitURL, htmlURL: String?
            public let name, path, sha: String
            public let size: Int
            public let type, url: String
            
            enum CodingKeys: String, CodingKey {
                case links = "_links"
                case content
                case downloadURL = "download_url"
                case gitURL = "git_url"
                case htmlURL = "html_url"
                case name, path, sha, size, type, url
            }
            
            public init(links: Links, content: String?, downloadURL: String?, gitURL: String?, htmlURL: String?, name: String, path: String, sha: String, size: Int, type: String, url: String) {
                self.links = links
                self.content = content
                self.downloadURL = downloadURL
                self.gitURL = gitURL
                self.htmlURL = htmlURL
                self.name = name
                self.path = path
                self.sha = sha
                self.size = size
                self.type = type
                self.url = url
            }
        }
        
        // MARK: - Links
        public struct Links: Codable, Equatable {
            public let git, html: String?
            public let linksSelf: String
            
            enum CodingKeys: String, CodingKey {
                case git, html
                case linksSelf = "self"
            }
            
            public init(git: String?, html: String?, linksSelf: String) {
                self.git = git
                self.html = html
                self.linksSelf = linksSelf
            }
        }
    }
}
