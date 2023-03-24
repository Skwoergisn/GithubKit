//
//  Models+User.swift
//  
//
//  Created by Dorian on 26/01/2023.
//

import Foundation

public extension Github.API.Models {
    /// User
    struct User: Codable, Equatable {
        public let avatarURL: String
        public let bio, blog: String?
        public let businessPlus: Bool?
        public let collaborators: Int?
        public let company: String?
        public let createdAt: Date
        public let diskUsage: Int?
        public let email: String?
        public let eventsURL: String
        public let followers: Int
        public let followersURL: String
        public let following: Int
        public let followingURL, gistsURL: String
        public let gravatarID: String?
        public let hireable: Bool?
        public let htmlURL: String
        public let id: Int
        public let ldapDN: String?
        public let location: String?
        public let login: String
        public let name: String?
        public let nodeID, organizationsURL: String
        public let ownedPrivateRepos: Int?
        public let plan: Plan?
        public let privateGists: Int?
        public let publicGists, publicRepos: Int
        public let receivedEventsURL, reposURL: String
        public let siteAdmin: Bool
        public let starredURL, subscriptionsURL: String
        public let suspendedAt: Date?
        public let totalPrivateRepos: Int?
        public let twitterUsername: String?
        public let twoFactorAuthentication: Bool?
        public let type: String
        public let updatedAt: Date
        public let url: String
        
        enum CodingKeys: String, CodingKey {
            case avatarURL = "avatar_url"
            case bio, blog
            case businessPlus = "business_plus"
            case collaborators, company
            case createdAt = "created_at"
            case diskUsage = "disk_usage"
            case email
            case eventsURL = "events_url"
            case followers
            case followersURL = "followers_url"
            case following
            case followingURL = "following_url"
            case gistsURL = "gists_url"
            case gravatarID = "gravatar_id"
            case hireable
            case htmlURL = "html_url"
            case id
            case ldapDN = "ldap_dn"
            case location, login, name
            case nodeID = "node_id"
            case organizationsURL = "organizations_url"
            case ownedPrivateRepos = "owned_private_repos"
            case plan
            case privateGists = "private_gists"
            case publicGists = "public_gists"
            case publicRepos = "public_repos"
            case receivedEventsURL = "received_events_url"
            case reposURL = "repos_url"
            case siteAdmin = "site_admin"
            case starredURL = "starred_url"
            case subscriptionsURL = "subscriptions_url"
            case suspendedAt = "suspended_at"
            case totalPrivateRepos = "total_private_repos"
            case twitterUsername = "twitter_username"
            case twoFactorAuthentication = "two_factor_authentication"
            case type
            case updatedAt = "updated_at"
            case url
        }
        
        public init(avatarURL: String, bio: String?, blog: String?, businessPlus: Bool?, collaborators: Int?, company: String?, createdAt: Date, diskUsage: Int?, email: String?, eventsURL: String, followers: Int, followersURL: String, following: Int, followingURL: String, gistsURL: String, gravatarID: String?, hireable: Bool?, htmlURL: String, id: Int, ldapDN: String?, location: String?, login: String, name: String?, nodeID: String, organizationsURL: String, ownedPrivateRepos: Int?, plan: Plan?, privateGists: Int?, publicGists: Int, publicRepos: Int, receivedEventsURL: String, reposURL: String, siteAdmin: Bool, starredURL: String, subscriptionsURL: String, suspendedAt: Date?, totalPrivateRepos: Int?, twitterUsername: String?, twoFactorAuthentication: Bool?, type: String, updatedAt: Date, url: String) {
            self.avatarURL = avatarURL
            self.bio = bio
            self.blog = blog
            self.businessPlus = businessPlus
            self.collaborators = collaborators
            self.company = company
            self.createdAt = createdAt
            self.diskUsage = diskUsage
            self.email = email
            self.eventsURL = eventsURL
            self.followers = followers
            self.followersURL = followersURL
            self.following = following
            self.followingURL = followingURL
            self.gistsURL = gistsURL
            self.gravatarID = gravatarID
            self.hireable = hireable
            self.htmlURL = htmlURL
            self.id = id
            self.ldapDN = ldapDN
            self.location = location
            self.login = login
            self.name = name
            self.nodeID = nodeID
            self.organizationsURL = organizationsURL
            self.ownedPrivateRepos = ownedPrivateRepos
            self.plan = plan
            self.privateGists = privateGists
            self.publicGists = publicGists
            self.publicRepos = publicRepos
            self.receivedEventsURL = receivedEventsURL
            self.reposURL = reposURL
            self.siteAdmin = siteAdmin
            self.starredURL = starredURL
            self.subscriptionsURL = subscriptionsURL
            self.suspendedAt = suspendedAt
            self.totalPrivateRepos = totalPrivateRepos
            self.twitterUsername = twitterUsername
            self.twoFactorAuthentication = twoFactorAuthentication
            self.type = type
            self.updatedAt = updatedAt
            self.url = url
        }
        
        // MARK: - Plan
        public struct Plan: Codable, Equatable {
            public let collaborators: Int
            public let name: String
            public let privateRepos, space: Int
            
            enum CodingKeys: String, CodingKey {
                case collaborators, name
                case privateRepos = "private_repos"
                case space
            }
            
            public init(collaborators: Int, name: String, privateRepos: Int, space: Int) {
                self.collaborators = collaborators
                self.name = name
                self.privateRepos = privateRepos
                self.space = space
            }
        }
    }
}
