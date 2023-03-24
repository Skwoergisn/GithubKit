//
//  File.swift
//  
//
//  Created by Dorian on 28/01/2023.
//

import Foundation

public extension Github.API.Models {
    /// Git references within a repository
    struct Reference: Codable, Equatable {
        public let nodeID: String
        public let object: Object
        public let ref, url: String
        
        enum CodingKeys: String, CodingKey {
            case nodeID = "node_id"
            case object, ref, url
        }
        
        public init(nodeID: String, object: Object, ref: String, url: String) {
            self.nodeID = nodeID
            self.object = object
            self.ref = ref
            self.url = url
        }
        
        // MARK: - Object
        public struct Object: Codable, Equatable {
            /// SHA for the reference
            public let sha: String
            public let type, url: String
            
            public init(sha: String, type: String, url: String) {
                self.sha = sha
                self.type = type
                self.url = url
            }
        }
    }
}
