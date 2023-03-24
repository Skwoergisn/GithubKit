//
//  File.swift
//  
//
//  Created by Dorian on 30/01/2023.
//

import Foundation

/**
 A wrapper that always explicitly encodes its optional value, even if it is `nil`.
 */
@propertyWrapper
struct NullEncodable<Value>: Encodable where Value: Encodable {
    
    var wrappedValue: Value?

    init(wrappedValue: Value?) {
        self.wrappedValue = wrappedValue
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch wrappedValue {
        case .some(let value): try container.encode(value)
        case .none: try container.encodeNil()
        }
    }
}
