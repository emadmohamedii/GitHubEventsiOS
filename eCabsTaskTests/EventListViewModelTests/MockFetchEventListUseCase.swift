//
//  MockFetchEventListUseCase.swift
//  eCabsTaskTests
//
//  Created by Emad Habib on 14/09/2024.
//

import Foundation
@testable import eCabsTask

// Mock the FetchEventListUseCaseProtocol for testing
class MockFetchEventListUseCase: FetchEventListUseCaseProtocol {
    var stubbedEvents: [GitHubEvent] = []
    var stubbedError: Error?
    
    func excute(filter: EventType) async throws -> [GitHubEvent] {
        if let error = stubbedError {
            throw error
        }
        return stubbedEvents
    }
}
