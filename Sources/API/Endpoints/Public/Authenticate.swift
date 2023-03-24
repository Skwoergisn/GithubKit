//
//  File.swift
//  
//
//  Created by Dorian on 27/01/2023.
//

import Foundation
import Netswift

public extension Github.API.Public {
    struct Authenticate {
        internal let api: Github.API.Public
        
        public let baseURL: URL
        public let redirectURL: URL
    }
}
