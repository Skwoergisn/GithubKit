//
//  Models+GithubFileRepresentable.swift
//  
//
//  Created by Dorian on 29/01/2023.
//

import Foundation

///  A type that can be represented as a Github Blob
public protocol GithubFileRepresentable {
    /// The path of the file this blob represents (should include filename)
    var path: String { get }
    /// The blob's content
    var contents: Github.API.Models.Blob.Contents { get }
}

public extension Github.API.Models {
    /// A simple structure that can be used to represent a file
    struct File: GithubFileRepresentable {
        public let path: String
        public let contents: Github.API.Models.Blob.Contents
        
        public init(path: String, contents: Github.API.Models.Blob.Contents) {
            self.path = path
            self.contents = contents
        }
        
        public init(path: String, contents: String) {
            self.path = path
            self.contents = .string(contents)
        }
        
        public init(path: String, contents: Data) {
            self.path = path
            self.contents = .data(contents)
        }
    }
}
