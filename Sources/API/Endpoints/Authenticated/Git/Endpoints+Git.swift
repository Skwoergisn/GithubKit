//
//  Endpoints+Git.swift
//  
//
//  Created by Dorian on 27/01/2023.
//

import Foundation

public extension Github.API.Authenticated {
    struct Git {
        let api: Github.API.Authenticated
        
        /**
         Creates a git commit with the given files.
         
         - parameters:
            - files: The files to commit.
            - repository: The repository in which the commit should be created.
            - branch: The branch under which the commit should be anchored. Defaults to `main`.
            - message: The commit message.
         */
        public func commit(_ files: [GithubFileRepresentable],
                           to repository: Github.API.Models.Repository,
                           branch: String = "main",
                           message: String) async throws {
            // Get root tree
            let rootTree = try await rootTree(of: repository, branch: branch)
            
            // Get head reference
            let headReference = try await headReference(of: repository, branch: branch)
            
            // Create blobs
            let blobs: [Github.API.Models.Tree.Element] = try await files.concurrentMap({ blob in
                    .init(path: blob.path,
                          sha: try await createBlob(contents: blob.contents, in: repository).sha)
            })
            
            // Create tree
            let newTree = try await createTree(containing: blobs, in: repository, under: rootTree)
            
            // Commit tree
            let commit = try await commit(message: message, for: newTree, ancestors: [headReference.object.sha], in: repository)
            
            // Update reference
            guard try await updateRef(for: commit, in: repository, branch: branch).object.sha == commit.sha else {
                throw Error.refUpdateShaMismatch
            }
        }
        
        public func createBlob(
            contents: Github.API.Models.Blob.Contents,
            in repository: Github.API.Models.Repository
        ) async throws -> Github.API.Models.Blob {
            try await api.perform(
                Endpoints.Blobs(
                    token: api.token,
                    owner: repository.owner.login,
                    repo: repository.name,
                    request: .create(contents: contents)
                )
            ).throwingValue()
        }
        
        /**
         Fetches the root tree object of the given repository, on the given branch
         
         - parameters:
            - repository: The repository on which to fetch the tree.
            - branch: The branch on which to fetch the root tree. Defaults to `main`.
         - returns: The repository's root tree.
         */
        public func rootTree(
            of repository: Github.API.Models.Repository,
            branch: String = "main"
        ) async throws -> Github.API.Models.Tree {
            try await api.perform(
                Endpoints.Trees(
                    token: api.token,
                    owner: repository.owner.login,
                    repo: repository.name,
                    request: .root(branch: branch))).throwingValue()
        }
        
        public func createTree(
            containing elements: [Github.API.Models.Tree.Element],
            in repository: Github.API.Models.Repository,
            under baseTree: Github.API.Models.Tree
        ) async throws -> Github.API.Models.Tree {
            try await api.perform(
                Endpoints.Trees(
                    token: api.token,
                    owner: repository.owner.login,
                    repo: repository.name,
                    request: .create(
                        body: .init(baseTreeSHA: baseTree.sha,
                                    items: elements)
                    ))
            ).throwingValue()
        }
        
        /**
         Fetches the head reference of the given repository, on the given branch
         
         - parameters:
            - repository: The repository on which to fetch the commit.
            - branch: The branch on which to fetch the parent commit. Defaults to `main`.
         - returns: The repository's branch's parent commit.
         */
        public func headReference(
            of repository: Github.API.Models.Repository,
            branch: String = "main"
        ) async throws -> Github.API.Models.Reference {
            try await api.perform(
                Endpoints.Reference(
                    token: api.token,
                    owner: repository.owner.login,
                    repo: repository.name,
                    branch: branch,
                    request: .head)
            ).throwingValue()
        }
        
        public func commit(
            message: String,
            for tree: Github.API.Models.Tree,
            ancestors: [String],
            in repository: Github.API.Models.Repository
        ) async throws -> Github.API.Models.Commit {
            try await api.perform(
                Endpoints.Commit(
                    token: api.token,
                    owner: repository.owner.login,
                    repo: repository.name,
                    request: .create(
                        body: .init(treeSHA: tree.sha,
                                    message: message,
                                    parentCommitsSHAs: ancestors))
                )
            ).throwingValue()
        }
        
        public func updateRef(
            for commit: Github.API.Models.Commit,
            in repository: Github.API.Models.Repository,
            branch: String = "main"
        ) async throws -> Github.API.Models.Reference {
            try await api.perform(
                Endpoints.Reference(
                    token: api.token,
                    owner: repository.owner.login,
                    repo: repository.name,
                    branch: branch,
                    request: .update(sha: commit.sha))
            ).throwingValue()
        }
    }
}

public extension Github.API.Authenticated {
    /// Git Database endpoints
    var git: Git {
        .init(api: self)
    }
}

extension Github.API.Authenticated.Git {
    /// Endpoints namespace
    enum Endpoints {}
}

public extension Github.API.Authenticated.Git {
    enum Error: Swift.Error {
        case refUpdateShaMismatch
    }
}
