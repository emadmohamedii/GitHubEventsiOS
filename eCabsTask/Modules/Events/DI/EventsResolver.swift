//
//  EventsResolver.swift
//  eCabsTask
//
//  Created by Emad Habib on 12/09/2024.
//

final class DependencyInjection {
    static func resolve() -> EventListViewModel {
        let repository = EventListRepository()
        let eventsUseCase = FetchEventListUseCase(repository: repository)
        return EventListViewModel(eventListUseCase: eventsUseCase)
    }
}
