//
//  Github+Configuration.swift
//  
//
//  Created by Dorian on 15/01/2023.
//

import Foundation

public extension Github {
    struct Configuration: Codable, Hashable, Identifiable {
        
        public var id: String { token }
        
        public let token: String
        public let scope: String
        public let tokenType: String
        
        internal let base64EncodedToken: String
        
        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.token = try container.decode(String.self, forKey: .token)
            self.scope = try container.decode(String.self, forKey: .scope)
            self.tokenType = try container.decode(String.self, forKey: .tokenType)
            guard let base64EncodedToken = token.data(using: .utf8)?.base64EncodedString() else {
                throw DecodingError.dataCorrupted(.init(codingPath: [CodingKeys.token],
                                                        debugDescription: "Unable to generate Base64-encoded String from Token"))
            }
            self.base64EncodedToken = base64EncodedToken
        }
        
        enum CodingKeys: String, CodingKey {
            case token = "access_token"
            case scope = "scope"
            case tokenType = "token_type"
        }
    }
}
