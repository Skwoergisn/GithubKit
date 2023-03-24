//
//  File.swift
//  
//
//  Created by Dorian on 27/01/2023.
//

import Foundation

public extension Github.API.Models {
    struct Blob: Codable {
        public let sha: String
        public let url: URL
    }
}

public extension Github.API.Models.Blob {
    /// A blob encoding type
    enum Contents: Codable, Equatable {
        /// Raw Data
        case data(Data)
        /// Raw String
        case string(String)
        
        /// The base 64 encoded string value of the contents
        var encodedValue: String {
            switch self {
            case let .data(data):
                return data.base64EncodedString()
            case let .string(string):
                return string
            }
        }
        
        /// The key used for encoding
        var key: Key {
            switch self {
            case .data: return .base64
            case .string: return .utf8
            }
        }
        
        public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(key, forKey: .encoding)
            try container.encode(encodedValue, forKey: .content)
        }
        
        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            let key = try container.decode(Key.self, forKey: .encoding)
            switch key {
            case .utf8:
                self = .string(try container.decode(String.self, forKey: .content))
            case .base64:
                self = .data(try container.decode(Data.self, forKey: .content))
            }
        }
        
        enum Key: String, Codable {
            case base64 = "base64"
            case utf8 = "utf_8"
        }
        
        enum CodingKeys: String, CodingKey {
            case content = "content"
            case encoding = "encoding"
        }
    }
}
