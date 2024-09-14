//
//  FetchEventListRepositoryProtocol.swift
//  eCabsTask
//
//  Created by Emad Habib on 12/09/2024.
//

protocol EventListRepositoryProtocol {
    func fetchGitHubEvents() async throws -> [GitHubEvent]
}
