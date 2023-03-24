//
//  File.swift
//  
//
//  Created by Dorian on 27/01/2023.
//

import Foundation
import Netswift

extension NetswiftResult {
    
    /**
     Returns this result's success value, or throws its error.
     */
    func throwingValue() throws -> Success {
        switch self {
        case let .success(success): return success
        case let .failure(error): throw error
        }
    }
}
