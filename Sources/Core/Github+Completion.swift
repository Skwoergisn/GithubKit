//
//  Github+Completion.swift
//  
//
//  Created by Dorian on 15/01/2023.
//

import Foundation

public extension Github {
    typealias Completion = (_ config: CompletionResult) -> Void
}

public extension Github {
    typealias CompletionResult = Result<Github.Configuration, Error>
}
