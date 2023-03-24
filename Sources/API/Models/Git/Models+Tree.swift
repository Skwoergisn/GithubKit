//
//  Models+Tree.swift
//  
//
//  Created by Dorian on 27/01/2023.
//

import Foundation

public extension Github.API.Models {
    /// The hierarchy between files in a Git repository.
    struct Tree: Codable, Equatable {
        public let sha: String
        /// Objects specifying a tree structure
        public let tree: [Element]
        public let truncated: Bool
        public let url: String
        
        public struct Element: Codable, Equatable {
            public let path, sha: String?
            public let mode: Mode
            public let size: Int?
            public let url: String?
            public var type: `Type`
            
            init(path: String, sha: String, mode: Mode = .file) {
                self.path = path
                self.sha = sha
                self.mode = mode
                self.type = .init(from: mode)
                self.size = nil
                self.url = nil
            }
            
            public enum Mode: String, Codable {
                case file = "100644"
                case executable = "100755"
                case subtree = "040000"
                case submodule = "160000"
                case symlink = "120000"
            }
            
            public enum `Type`: String, Codable {
                case blob
                case tree
                case commit
                
                init(from mode: Mode) {
                    switch mode {
                    case .file, .executable, .symlink:
                        self = .blob
                    case .submodule:
                        self = .commit
                    case .subtree:
                        self = .tree
                    }
                }
            }
        }
    }
}
