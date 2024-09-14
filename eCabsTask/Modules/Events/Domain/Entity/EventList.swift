//
//  GitHubEvent.swift
//  eCabsTask
//
//  Created by Emad Habib on 12/09/2024.
//

import Foundation

// MARK: - GitHubEvent
struct GitHubEvent : Codable , Identifiable , Equatable {
    let actor : Actor
    let id : String
    let type : String
    let createdAt : String
    let repo: Repo
    
    enum CodingKeys: String, CodingKey {
        case actor
        case createdAt = "created_at"
        case id = "id"
        case type = "type"
        case repo = "repo"
    }
}

extension GitHubEvent {
    static func == (lhs: GitHubEvent, rhs: GitHubEvent) -> Bool {
        return lhs.id == rhs.id
    }
}

// MARK: - Repo
struct Repo: Codable {
    let name: String
}

// MARK: - Actor
struct Actor : Codable {
    let avatarUrl : String?
    let displayLogin : String
    
    enum CodingKeys: String, CodingKey {
        case avatarUrl = "avatar_url"
        case displayLogin = "display_login"
    }
}
