//
//  File.swift
//  
//
//  Created by Dorian on 24/01/2023.
//

import Foundation
import Netswift

/// A type that represents how a Github request is routed, serialised, decoded & performed.
protocol GithubEndpoint: NetswiftRoute, NetswiftRequest {}

/// A type that represents a Github request that requires authentication
protocol GithubAuthenticatedEndpoint: GithubEndpoint {
    var token: String { get }
}

// MARK: - Default Implementations

extension GithubEndpoint {
    var scheme: NetswiftScheme { .https }
    var host: String? { "api.github.com" }
    
    var headers: NetswiftHeaders {
        Self.defaultHeaders
    }
    
    static var defaultHeaders: NetswiftHeaders {
        .init(accept: .github(.object), contentType: .json)
    }
}

extension GithubAuthenticatedEndpoint {
    
    var headers: NetswiftHeaders {
        defaultAuthenticatedHeaders
    }
    
    var defaultAuthenticatedHeaders: NetswiftHeaders {
        var headers = Self.defaultHeaders
        headers.authorization = .basic(token: token)
        return headers
    }
}

extension GithubEndpoint where Response: Decodable {
    func deserialise(_ incomingData: Data) -> NetswiftResult<Response> {
        Self.defaultDeserialise(incomingData: incomingData)
    }
    
    /// Default deserialisation logic.
    ///
    /// Can be used to decode any decodable type, but defaults to decoding the `Response` type.
    static func defaultDeserialise<T: Decodable>(type: T.Type = Response.self, incomingData: Data) -> NetswiftResult<T> {
        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            decoder.dataDecodingStrategy = .base64
            let decodedResponse = try decoder.decode(T.self, from: incomingData)
            return .success(decodedResponse)
            
        } catch let error as DecodingError {
            return .failure(.init(category: .responseDecodingError(error: error), payload: incomingData))
        } catch {
            return .failure(.init(category: .unexpectedResponseError, payload: incomingData))
        }
    }
}
