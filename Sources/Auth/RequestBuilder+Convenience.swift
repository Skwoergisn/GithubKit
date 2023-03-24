//
//  File.swift
//  
//
//  Created by Dorian on 15/01/2023.
//

import Foundation

extension Github.Configuration.RequestBuilder {
    
    fileprivate typealias Error = Github.AuthError
    
    public func responds(to url: URL) -> Bool {
        guard let scheme = url.scheme else { return false }
        return scheme == redirectURL.scheme
    }
    
    public func getCode(from url: URL) throws -> String {
        let components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        
        guard components?.queryItems?.first(where: { item in
            item == queryItems.state
        }) != nil else {
            throw Error.crossSiteForgeryDetected
        }
        
        let item = components?.queryItems?.first(where: { item in
            item.name == "code"
        })
        guard let item, let code = item.value else {
            throw Error.noAuthCode
        }
        
        return code
    }
}
