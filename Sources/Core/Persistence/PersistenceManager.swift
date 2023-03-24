//
//  PersistenceManager.swift
//  
//
//  Created by Dorian on 24/03/2023.
//

import Foundation
import KeychainSwift

class PersistenceManager {
    
    let keychain: KeychainSwift
    let jsonCoder: JSONCoder
    
    private static let key: String = "config"
    
    init(accessGroup: String) {
        let keychain: KeychainSwift = .init()
        keychain.accessGroup = accessGroup
        self.keychain = keychain
        self.jsonCoder = .init()
    }
    
    func readConfiguration() -> Github.Configuration? {
        guard let data = keychain.getData(Self.key) else { return nil }
        return try? jsonCoder.decode(data: data)
    }
    
    func persistConfiguration(_ config: Github.Configuration) {
        guard let data = try? jsonCoder.encode(value: config) else { return }
        keychain.set(data, forKey: Self.key)
    }
}
