//
//  Github.swift
//  
//
//  Created by Dorian on 15/01/2023.
//

import Foundation

/// Github Namespace
public struct Github {
    let requestBuilder: Configuration.RequestBuilder
    let persistenceManager: PersistenceManager
    
    public static var configuration: Github.Configuration? {
        Self.shared?.persistenceManager.readConfiguration()
    }
    
    static private(set) var shared: Github?
    
    public static func configure(
        clientID: String,
        clientSecret: String,
        baseURL: URL = URL(string: "https://github.com/login/oauth")!,
        redirectURL: URL
    ) {
        shared = .init(
            requestBuilder: .init(
                clientID: clientID,
                clientSecret: clientSecret,
                baseURL: baseURL,
                redirectURL: redirectURL
            ),
            persistenceManager: .init()
        )
    }
}
