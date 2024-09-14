//
//  EventListViewModelTests.swift
//  eCabsTaskTests
//
//  Created by Emad Habib on 14/09/2024.
//

import XCTest
@testable import eCabsTask

class EventListViewModelTests: XCTestCase {
    var viewModel: EventListViewModel!
    var mockUseCase: MockFetchEventListUseCase!
    
    override func setUp() {
        super.setUp()
        mockUseCase = MockFetchEventListUseCase()
        viewModel = EventListViewModel(eventListUseCase: mockUseCase)
    }
    
    override func tearDown() {
        viewModel.stopPolling()
        viewModel = nil
        mockUseCase = nil
        super.tearDown()
    }
    
    func testInitialLoad() async throws {
        // Arrange
        let expectedEvents = [GitHubEvent(
            actor: Actor(
                avatarUrl: nil,
                displayLogin: "user"
            ),
            id: "1",
            type: "WatchEvent",
            createdAt: "2024-09-14T00:00:00Z",
            repo: Repo(name: "repo")
        )]
        mockUseCase.stubbedEvents = expectedEvents
        
        // Act
        await viewModel.loadEvents()
        
        // Assert
        XCTAssertEqual(viewModel.events, expectedEvents)
        XCTAssertFalse(viewModel.isEmpty)
        XCTAssertEqual(viewModel.errorMessage, "")
        XCTAssertFalse(viewModel.isLoading)
    }
    
    func testLoadEventsFailure() async throws {
        // Arrange
        mockUseCase.stubbedError = NSError(domain: "", code: -1, userInfo: nil)
        
        // Act
        await viewModel.loadEvents()
        
        // Assert
        XCTAssertTrue(viewModel.events.isEmpty)
        XCTAssertTrue(viewModel.isEmpty)
        XCTAssertEqual(viewModel.errorMessage, "Failed to load events: The operation couldn’t be completed. ( error -1.)")
    }
    
    func testSetEventType() async throws {
        // Arrange
        let expectedEvents = [GitHubEvent(
            actor: Actor(avatarUrl: nil, displayLogin: "user"),
            id: "1",
            type: "WatchEvent",
            createdAt: "2024-09-14T00:00:00Z",
            repo: Repo(name: "repo")
        )]
        mockUseCase.stubbedEvents = expectedEvents
        
        // Act
        viewModel.setEventType(.watch)
        
        // Assert
        // Wait for the async operation to complete
        let expectation = XCTestExpectation(description: "Set Event Type and Load Events")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertEqual(self.viewModel.events, expectedEvents)
            XCTAssertFalse(self.viewModel.isEmpty)
            expectation.fulfill()
        }

        await fulfillment(of: [expectation], timeout: 2, enforceOrder: false)
    }
    
    func testRetryLoadEvents() async throws {
        // Arrange
        let expectedEvents = [GitHubEvent(
            actor: Actor(avatarUrl: nil, displayLogin: "user"),
            id: "1",
            type: "WatchEvent",
            createdAt: "2024-09-14T00:00:00Z",
            repo: Repo(name: "repo")
        )]
        mockUseCase.stubbedEvents = expectedEvents
        
        // Act
        viewModel.retryLoadEvents()
        
        // Assert
        // Wait for the async operation to complete
        let expectation = XCTestExpectation(description: "Retry Load Events")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertEqual(self.viewModel.events, expectedEvents)
            XCTAssertFalse(self.viewModel.isEmpty)
            expectation.fulfill()
        }
        await fulfillment(of: [expectation], timeout: 2, enforceOrder: false)
    }
}
