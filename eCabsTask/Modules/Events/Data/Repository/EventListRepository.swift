//
//  EventListRepository.swift
//  eCabsTask
//
//  Created by Emad Habib on 12/09/2024.
//

import CoreNetwork

final class EventListRepository: EventListRepositoryProtocol {
    private var service : Networkable = NetworkService.shared
    
    func fetchGitHubEvents() async throws -> [GitHubEvent] {
        let endpoint = EventListRouter.eventList
        return try await service.sendRequest(endpoint: endpoint)
    }
}
