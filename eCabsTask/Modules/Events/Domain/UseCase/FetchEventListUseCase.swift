//
//  FetchEventListUseCase.swift
//  eCabsTask
//
//  Created by Emad Habib on 12/09/2024.
//

protocol FetchEventListUseCaseProtocol {
    func execute(filter: EventType) async throws -> [GitHubEvent]
}

final class FetchEventListUseCase : FetchEventListUseCaseProtocol {
    private let repository: EventListRepositoryProtocol
    
    init(repository: EventListRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(filter: EventType) async throws -> [GitHubEvent] {
        let events = try await repository.fetchGitHubEvents()
        return filter == .none ? events : events.filter({$0.type == filter.rawValue})
    }
}
