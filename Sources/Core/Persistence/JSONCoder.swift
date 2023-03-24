//
//  JSONCoder.swift
//  
//
//  Created by Dorian on 24/03/2023.
//

import Foundation

struct JSONCoder {
    private let encoder: JSONEncoder = .init()
    private let decoder: JSONDecoder = .init()
    
    func encode(value: Encodable) throws -> Data {
        try encoder.encode(value)
    }
    
    func decode<Value: Decodable>(data: Data) throws -> Value {
        try decoder.decode(Value.self, from: data)
    }
}
