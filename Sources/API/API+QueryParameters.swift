//
//  File.swift
//  
//
//  Created by Dorian on 27/01/2023.
//

import Foundation

public extension Github.API {
    struct QueryParameters {
        public let visibility: Visibility?
        public let affiliation: Affiliation?
        public let type: `Type`?
        public let sort: Sort?
        public let pagination: Pagination?
        public let dateInterval: DateInterval?
        
        public init(visibility: Visibility? = nil,
                    affiliation: Affiliation? = nil,
                    type: Type?, sort: Sort? = nil,
                    pagination: Pagination? = nil,
                    dateInterval: DateInterval? = nil) {
            self.visibility = visibility
            self.affiliation = affiliation
            self.type = type
            self.sort = sort
            self.pagination = pagination
            self.dateInterval = dateInterval
        }
        
        var query: String? {
            var components: URLComponents = .init()
            components.queryItems = [
                visibility?.queryItems,
                affiliation?.queryItems,
                type?.queryItems,
                sort?.queryItems,
                pagination?.queryItems,
                dateInterval?.queryItems
            ].flatMap { $0 ?? [] }
            
            return components.query
        }
    }
}

fileprivate protocol URLQueryItemRepresentable {
    var queryItems: [URLQueryItem] { get }
}

public extension Github.API.QueryParameters {
    
    /**
     Limit results to repositories with the specified visibility.

     - note: Defaults to `all`
     */
    enum Visibility: String, URLQueryItemRepresentable {
        case all, `public`, `private`
        
        var queryItems: [URLQueryItem] {
            [.init(name: "visibility", value: rawValue)]
        }
    }
    
    /**
     Comma-separated list of values.
     
     Can include:
        - `owner`: Repositories that are owned by the authenticated user.
        - `collaborator`: Repositories that the user has been added to as a collaborator.
        - `organization_member`: Repositories that the user has access to through being a member of an organization. This includes every repository on every team that the user is on.
     
     - note: Defaults to `[owner,collaborator,organization_member]`
     */
    struct Affiliation: URLQueryItemRepresentable {
        
        public let kinds: [Kind]
        
        init(kinds: [Kind] = [.owner, .collaborator, .organizationMember]) {
            self.kinds = kinds
        }
        
        public enum Kind: String {
            case owner, collaborator
            case organizationMember = "organization_member"
        }
        
        var queryItems: [URLQueryItem] {
            [.init(name: "affiliation", value: kinds.map(\.rawValue).joined(separator: ","))]
        }
    }
    
    /**
     Limit results to repositories of the specified type.
     
     - important: Will cause a `422` error if used in the same request as `visibility` or `affiliation`.
     
     - note: Defaults to `all`
     */
    enum `Type`: String, URLQueryItemRepresentable {
        case all, owner, `public`, `private`, member
        
        var queryItems: [URLQueryItem] {
            [.init(name: "type", value: rawValue)]
        }
    }
    
    /**
     Sorts the results by the given properties
     */
    struct Sort: URLQueryItemRepresentable {
        /**
         The property to sort the results by.

         - note: Defaults to `full_name`
         */
        public let kind: Kind
        
        /**
         The order to sort by.
         
         - note: Defaults to `asc` when using `full_name`, otherwise `desc`.
         */
        public let direction: Direction
        
        public init(kind: Kind = .fullName,
                    direction: Direction = .ascending) {
            self.kind = kind
            self.direction = direction
        }
        
        var queryItems: [URLQueryItem] {
            [
                .init(name: "sort", value: kind.rawValue),
                .init(name: "direction", value: direction.rawValue)
            ]
        }
        
        public enum Kind: String {
            case created, updated, pushed
            case fullName = "full_name"
        }
        
        public enum Direction: String {
            case ascending = "asc"
            case descending = "desc"
        }
    }
    
    struct Pagination: URLQueryItemRepresentable {
        /**
         Page number of the results to fetch.
         */
        public let page: Int
        /**
         The number of results per page.
         
         - note: Max 100
         */
        public let perPage: Int
        
        public init(page: Int = 1, perPage: Int = 30) {
            self.page = page
            self.perPage = max(100, perPage)
        }
        
        var queryItems: [URLQueryItem] {
            [
                .init(name: "page", value: "\(page)"),
                .init(name: "per_page", value: "\(perPage)")
            ]
        }
    }
}

extension DateInterval: URLQueryItemRepresentable {
    var queryItems: [URLQueryItem] {
        let formatter = ISO8601DateFormatter()
        return [
            .init(name: "since", value: formatter.string(from: start)),
            .init(name: "before", value: formatter.string(from: end))
        ]
    }
}
