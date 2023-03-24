//
//  MimeType+Github.swift
//  
//
//  Created by Dorian on 26/01/2023.
//

import Foundation
import Netswift

public extension MimeType {
    
    /// Vendor-specific formats
    enum Github: String {
        
        /// Raw contents
        case raw
        
        /// Contents wrapped in a Github JSON object
        case object
        
        /// Contents wrapped in a displayable HTML format
        case html
    }
    
    /// Github MimeTypes
    static func github(_ github: Github) -> MimeType {
        .custom(type: "application/vnd.github.\(github.rawValue)")
    }
}
