//
//  Models+Repository.swift
//
//
//  Created by Dorian on 26/01/2023.
//

import Foundation

public extension Github.API.Models {
    /// Minimal Repository
    // MARK: - MinimalRepository
    struct Repository: Codable, Equatable {
        public let allowForking: Bool?
        public let archiveURL: String
        public let archived: Bool?
        public let assigneesURL, blobsURL, branchesURL: String
        public let cloneURL: String?
        /// Code Of Conduct
        public let codeOfConduct: CodeOfConduct?
        public let collaboratorsURL, commentsURL, commitsURL, compareURL: String
        public let contentsURL, contributorsURL: String
        public let createdAt: Date?
        public let defaultBranch: String?
        public let deleteBranchOnMerge: Bool?
        public let deploymentsURL: String
        public let description: String?
        public let disabled: Bool?
        public let downloadsURL, eventsURL: String
        public let fork: Bool
        public let forks, forksCount: Int?
        public let forksURL, fullName, gitCommitsURL, gitRefsURL: String
        public let gitTagsURL: String
        public let gitURL: String?
        public let hasDiscussions, hasDownloads, hasIssues, hasPages: Bool?
        public let hasProjects, hasWiki: Bool?
        public let homepage: String?
        public let hooksURL, htmlURL: String
        public let id: Int
        public let isTemplate: Bool?
        public let issueCommentURL, issueEventsURL, issuesURL, keysURL: String
        public let labelsURL: String
        public let language: String?
        public let languagesURL: String
        public let license: License?
        public let mergesURL, milestonesURL: String
        public let mirrorURL: String?
        public let name: String
        public let networkCount: Int?
        public let nodeID, notificationsURL: String
        public let openIssues, openIssuesCount: Int?
        /// A GitHub user.
        public let owner: SimpleUser
        public let permissions: Permissions?
        public let minimalRepositoryPrivate: Bool
        public let pullsURL: String
        public let pushedAt: Date?
        public let releasesURL: String
        public let roleName: String?
        public let securityAndAnalysis: SecurityAndAnalysis?
        /// The size of the repository. Size is calculated hourly. When a repository is initially
        /// created, the size is 0.
        public let size: Int?
        public let sshURL: String?
        public let stargazersCount: Int?
        public let stargazersURL, statusesURL: String
        public let subscribersCount: Int?
        public let subscribersURL, subscriptionURL: String
        public let svnURL: String?
        public let tagsURL, teamsURL: String
        public let tempCloneToken: String?
        public let topics: [String]?
        public let treesURL: String
        public let updatedAt: Date?
        public let url: String
        public let visibility: String?
        public let watchers, watchersCount: Int?
        public let webCommitSignoffRequired: Bool?
        
        enum CodingKeys: String, CodingKey {
            case allowForking = "allow_forking"
            case archiveURL = "archive_url"
            case archived
            case assigneesURL = "assignees_url"
            case blobsURL = "blobs_url"
            case branchesURL = "branches_url"
            case cloneURL = "clone_url"
            case codeOfConduct = "code_of_conduct"
            case collaboratorsURL = "collaborators_url"
            case commentsURL = "comments_url"
            case commitsURL = "commits_url"
            case compareURL = "compare_url"
            case contentsURL = "contents_url"
            case contributorsURL = "contributors_url"
            case createdAt = "created_at"
            case defaultBranch = "default_branch"
            case deleteBranchOnMerge = "delete_branch_on_merge"
            case deploymentsURL = "deployments_url"
            case description, disabled
            case downloadsURL = "downloads_url"
            case eventsURL = "events_url"
            case fork, forks
            case forksCount = "forks_count"
            case forksURL = "forks_url"
            case fullName = "full_name"
            case gitCommitsURL = "git_commits_url"
            case gitRefsURL = "git_refs_url"
            case gitTagsURL = "git_tags_url"
            case gitURL = "git_url"
            case hasDiscussions = "has_discussions"
            case hasDownloads = "has_downloads"
            case hasIssues = "has_issues"
            case hasPages = "has_pages"
            case hasProjects = "has_projects"
            case hasWiki = "has_wiki"
            case homepage
            case hooksURL = "hooks_url"
            case htmlURL = "html_url"
            case id
            case isTemplate = "is_template"
            case issueCommentURL = "issue_comment_url"
            case issueEventsURL = "issue_events_url"
            case issuesURL = "issues_url"
            case keysURL = "keys_url"
            case labelsURL = "labels_url"
            case language
            case languagesURL = "languages_url"
            case license
            case mergesURL = "merges_url"
            case milestonesURL = "milestones_url"
            case mirrorURL = "mirror_url"
            case name
            case networkCount = "network_count"
            case nodeID = "node_id"
            case notificationsURL = "notifications_url"
            case openIssues = "open_issues"
            case openIssuesCount = "open_issues_count"
            case owner, permissions
            case minimalRepositoryPrivate = "private"
            case pullsURL = "pulls_url"
            case pushedAt = "pushed_at"
            case releasesURL = "releases_url"
            case roleName = "role_name"
            case securityAndAnalysis = "security_and_analysis"
            case size
            case sshURL = "ssh_url"
            case stargazersCount = "stargazers_count"
            case stargazersURL = "stargazers_url"
            case statusesURL = "statuses_url"
            case subscribersCount = "subscribers_count"
            case subscribersURL = "subscribers_url"
            case subscriptionURL = "subscription_url"
            case svnURL = "svn_url"
            case tagsURL = "tags_url"
            case teamsURL = "teams_url"
            case tempCloneToken = "temp_clone_token"
            case topics
            case treesURL = "trees_url"
            case updatedAt = "updated_at"
            case url, visibility, watchers
            case watchersCount = "watchers_count"
            case webCommitSignoffRequired = "web_commit_signoff_required"
        }
        
        public init(allowForking: Bool?, archiveURL: String, archived: Bool?, assigneesURL: String, blobsURL: String, branchesURL: String, cloneURL: String?, codeOfConduct: CodeOfConduct?, collaboratorsURL: String, commentsURL: String, commitsURL: String, compareURL: String, contentsURL: String, contributorsURL: String, createdAt: Date?, defaultBranch: String?, deleteBranchOnMerge: Bool?, deploymentsURL: String, description: String?, disabled: Bool?, downloadsURL: String, eventsURL: String, fork: Bool, forks: Int?, forksCount: Int?, forksURL: String, fullName: String, gitCommitsURL: String, gitRefsURL: String, gitTagsURL: String, gitURL: String?, hasDiscussions: Bool?, hasDownloads: Bool?, hasIssues: Bool?, hasPages: Bool?, hasProjects: Bool?, hasWiki: Bool?, homepage: String?, hooksURL: String, htmlURL: String, id: Int, isTemplate: Bool?, issueCommentURL: String, issueEventsURL: String, issuesURL: String, keysURL: String, labelsURL: String, language: String?, languagesURL: String, license: License?, mergesURL: String, milestonesURL: String, mirrorURL: String?, name: String, networkCount: Int?, nodeID: String, notificationsURL: String, openIssues: Int?, openIssuesCount: Int?, owner: SimpleUser, permissions: Permissions?, minimalRepositoryPrivate: Bool, pullsURL: String, pushedAt: Date?, releasesURL: String, roleName: String?, securityAndAnalysis: SecurityAndAnalysis?, size: Int?, sshURL: String?, stargazersCount: Int?, stargazersURL: String, statusesURL: String, subscribersCount: Int?, subscribersURL: String, subscriptionURL: String, svnURL: String?, tagsURL: String, teamsURL: String, tempCloneToken: String?, topics: [String]?, treesURL: String, updatedAt: Date?, url: String, visibility: String?, watchers: Int?, watchersCount: Int?, webCommitSignoffRequired: Bool?) {
            self.allowForking = allowForking
            self.archiveURL = archiveURL
            self.archived = archived
            self.assigneesURL = assigneesURL
            self.blobsURL = blobsURL
            self.branchesURL = branchesURL
            self.cloneURL = cloneURL
            self.codeOfConduct = codeOfConduct
            self.collaboratorsURL = collaboratorsURL
            self.commentsURL = commentsURL
            self.commitsURL = commitsURL
            self.compareURL = compareURL
            self.contentsURL = contentsURL
            self.contributorsURL = contributorsURL
            self.createdAt = createdAt
            self.defaultBranch = defaultBranch
            self.deleteBranchOnMerge = deleteBranchOnMerge
            self.deploymentsURL = deploymentsURL
            self.description = description
            self.disabled = disabled
            self.downloadsURL = downloadsURL
            self.eventsURL = eventsURL
            self.fork = fork
            self.forks = forks
            self.forksCount = forksCount
            self.forksURL = forksURL
            self.fullName = fullName
            self.gitCommitsURL = gitCommitsURL
            self.gitRefsURL = gitRefsURL
            self.gitTagsURL = gitTagsURL
            self.gitURL = gitURL
            self.hasDiscussions = hasDiscussions
            self.hasDownloads = hasDownloads
            self.hasIssues = hasIssues
            self.hasPages = hasPages
            self.hasProjects = hasProjects
            self.hasWiki = hasWiki
            self.homepage = homepage
            self.hooksURL = hooksURL
            self.htmlURL = htmlURL
            self.id = id
            self.isTemplate = isTemplate
            self.issueCommentURL = issueCommentURL
            self.issueEventsURL = issueEventsURL
            self.issuesURL = issuesURL
            self.keysURL = keysURL
            self.labelsURL = labelsURL
            self.language = language
            self.languagesURL = languagesURL
            self.license = license
            self.mergesURL = mergesURL
            self.milestonesURL = milestonesURL
            self.mirrorURL = mirrorURL
            self.name = name
            self.networkCount = networkCount
            self.nodeID = nodeID
            self.notificationsURL = notificationsURL
            self.openIssues = openIssues
            self.openIssuesCount = openIssuesCount
            self.owner = owner
            self.permissions = permissions
            self.minimalRepositoryPrivate = minimalRepositoryPrivate
            self.pullsURL = pullsURL
            self.pushedAt = pushedAt
            self.releasesURL = releasesURL
            self.roleName = roleName
            self.securityAndAnalysis = securityAndAnalysis
            self.size = size
            self.sshURL = sshURL
            self.stargazersCount = stargazersCount
            self.stargazersURL = stargazersURL
            self.statusesURL = statusesURL
            self.subscribersCount = subscribersCount
            self.subscribersURL = subscribersURL
            self.subscriptionURL = subscriptionURL
            self.svnURL = svnURL
            self.tagsURL = tagsURL
            self.teamsURL = teamsURL
            self.tempCloneToken = tempCloneToken
            self.topics = topics
            self.treesURL = treesURL
            self.updatedAt = updatedAt
            self.url = url
            self.visibility = visibility
            self.watchers = watchers
            self.watchersCount = watchersCount
            self.webCommitSignoffRequired = webCommitSignoffRequired
        }
        
        /// Code Of Conduct
        // MARK: - CodeOfConduct
        public struct CodeOfConduct: Codable, Equatable {
            public let body: String?
            public let htmlURL: String?
            public let key, name, url: String
            
            enum CodingKeys: String, CodingKey {
                case body
                case htmlURL = "html_url"
                case key, name, url
            }
            
            public init(body: String?, htmlURL: String?, key: String, name: String, url: String) {
                self.body = body
                self.htmlURL = htmlURL
                self.key = key
                self.name = name
                self.url = url
            }
        }
        // MARK: - License
        public struct License: Codable, Equatable {
            public let key, name, nodeID, spdxID: String?
            public let url: String?
            
            enum CodingKeys: String, CodingKey {
                case key, name
                case nodeID = "node_id"
                case spdxID = "spdx_id"
                case url
            }
            
            public init(key: String?, name: String?, nodeID: String?, spdxID: String?, url: String?) {
                self.key = key
                self.name = name
                self.nodeID = nodeID
                self.spdxID = spdxID
                self.url = url
            }
        }
        
        /// A GitHub user.
        // MARK: - SimpleUser
        public struct SimpleUser: Codable, Equatable {
            public let avatarURL: String
            public let email: String?
            public let eventsURL, followersURL, followingURL, gistsURL: String
            public let gravatarID: String?
            public let htmlURL: String
            public let id: Int
            public let login: String
            public let name: String?
            public let nodeID, organizationsURL, receivedEventsURL, reposURL: String
            public let siteAdmin: Bool
            public let starredAt: String?
            public let starredURL, subscriptionsURL, type, url: String
            
            enum CodingKeys: String, CodingKey {
                case avatarURL = "avatar_url"
                case email
                case eventsURL = "events_url"
                case followersURL = "followers_url"
                case followingURL = "following_url"
                case gistsURL = "gists_url"
                case gravatarID = "gravatar_id"
                case htmlURL = "html_url"
                case id, login, name
                case nodeID = "node_id"
                case organizationsURL = "organizations_url"
                case receivedEventsURL = "received_events_url"
                case reposURL = "repos_url"
                case siteAdmin = "site_admin"
                case starredAt = "starred_at"
                case starredURL = "starred_url"
                case subscriptionsURL = "subscriptions_url"
                case type, url
            }
            
            public init(avatarURL: String, email: String?, eventsURL: String, followersURL: String, followingURL: String, gistsURL: String, gravatarID: String?, htmlURL: String, id: Int, login: String, name: String?, nodeID: String, organizationsURL: String, receivedEventsURL: String, reposURL: String, siteAdmin: Bool, starredAt: String?, starredURL: String, subscriptionsURL: String, type: String, url: String) {
                self.avatarURL = avatarURL
                self.email = email
                self.eventsURL = eventsURL
                self.followersURL = followersURL
                self.followingURL = followingURL
                self.gistsURL = gistsURL
                self.gravatarID = gravatarID
                self.htmlURL = htmlURL
                self.id = id
                self.login = login
                self.name = name
                self.nodeID = nodeID
                self.organizationsURL = organizationsURL
                self.receivedEventsURL = receivedEventsURL
                self.reposURL = reposURL
                self.siteAdmin = siteAdmin
                self.starredAt = starredAt
                self.starredURL = starredURL
                self.subscriptionsURL = subscriptionsURL
                self.type = type
                self.url = url
            }
        }
        
        // MARK: - Permissions
        public struct Permissions: Codable, Equatable {
            public let admin, maintain, pull, push: Bool?
            public let triage: Bool?
            
            public init(admin: Bool?, maintain: Bool?, pull: Bool?, push: Bool?, triage: Bool?) {
                self.admin = admin
                self.maintain = maintain
                self.pull = pull
                self.push = push
                self.triage = triage
            }
        }
        
        // MARK: - SecurityAndAnalysis
        public struct SecurityAndAnalysis: Codable, Equatable {
            public let advancedSecurity: AdvancedSecurity?
            public let secretScanning: SecretScanning?
            public let secretScanningPushProtection: SecretScanningPushProtection?
            
            enum CodingKeys: String, CodingKey {
                case advancedSecurity = "advanced_security"
                case secretScanning = "secret_scanning"
                case secretScanningPushProtection = "secret_scanning_push_protection"
            }
            
            public init(advancedSecurity: AdvancedSecurity?, secretScanning: SecretScanning?, secretScanningPushProtection: SecretScanningPushProtection?) {
                self.advancedSecurity = advancedSecurity
                self.secretScanning = secretScanning
                self.secretScanningPushProtection = secretScanningPushProtection
            }
            
            // MARK: - AdvancedSecurity
            public struct AdvancedSecurity: Codable, Equatable {
                public let status: Status?
                
                public init(status: Status?) {
                    self.status = status
                }
            }
            
            public enum Status: String, Codable, Equatable {
                case disabled = "disabled"
                case enabled = "enabled"
            }
            
            // MARK: - SecretScanning
            public struct SecretScanning: Codable, Equatable {
                public let status: Status?
                
                public init(status: Status?) {
                    self.status = status
                }
            }
            
            // MARK: - SecretScanningPushProtection
            public struct SecretScanningPushProtection: Codable, Equatable {
                public let status: Status?
                
                public init(status: Status?) {
                    self.status = status
                }
            }
        }
    }
}
