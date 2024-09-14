import Foundation
import Combine

/**
 `EventListViewModel` is responsible for handling the presentation logic of the event list in the eCabs iOS application.

 This ViewModel manages fetching, filtering, and polling GitHub events and updating the UI based on the state of the data (loading, empty, or error). It supports automatic polling to refresh the event list periodically and allows users to filter events by type.

 The ViewModel uses the `@Published` properties to notify SwiftUI views about state changes.
 */

final class EventListViewModel: ObservableObject {
    
    // MARK: - Properties
    
    /// The list of GitHub events fetched from the API.
    @Published var events: [GitHubEvent] = []
    
    /// Indicates whether the app is currently loading events.
    @Published var isLoading: Bool = false
    
    /// The selected event type used to filter the event list.
    @Published var selectedEventType: EventType = .none // none before selecting any filter type
    
    /// Stores any error messages that occur during event loading.
    @Published var errorMessage: String = ""
    
    /// Indicates whether the event list is empty.
    @Published var isEmpty: Bool?
    
    /// The interval for polling GitHub events, set to 10 seconds.
    let pollingInterval: TimeInterval = 10.0
    
    /// The use case responsible for fetching the list of GitHub events.
    private let eventListUseCase: FetchEventListUseCaseProtocol
    
    /// Timer for polling events at regular intervals.
    private var timer: Timer?
    
    /// Boolean flag to track whether polling is active.
    var isPolling = false
    

    // MARK: - Init
    
    /**
     Initializes the `EventListViewModel` with a specific use case for fetching events.
     - Parameter eventListUseCase: The use case responsible for fetching events from the GitHub API.
     */
    init(eventListUseCase: FetchEventListUseCaseProtocol) {
        self.eventListUseCase = eventListUseCase
    }
    
    // MARK: - Methods
    
    /**
     Loads events from the GitHub API, either as an initial load or as a background refresh.
     
     - Parameter isBackgroundRefreshList: Determines whether this load is a background refresh or an initial load. Defaults to `false`.
     */
    func loadEvents(isBackgroundRefreshList:Bool = false) async {
        if !isBackgroundRefreshList {
            await MainActor.run { isLoading = true }
        }
        do {
            let fetchedEvents = try await eventListUseCase.execute(filter: selectedEventType)
            await MainActor.run {
                events = fetchedEvents
                isEmpty = fetchedEvents.isEmpty
                isLoading = false
            }
        }
        catch let error {
            // Stops polling if an error occurs
            stopPolling()
            await MainActor.run {
                errorMessage = "Failed to load events: \(error.localizedDescription)"
                isLoading = false
            }
        }
    }
    
    /**
     Sets the selected event type and reloads the events based on the new filter.
     
     - Parameter type: The `EventType` to filter the events by.
     */
    func setEventType(_ type: EventType) {
        selectedEventType = type
        Task { await loadEvents() }
    }
    
    /**
     Retries loading the events by resetting the event list and starting polling again.
     */
    func retryLoadEvents(){
        Task {
            await MainActor.run { events = [] }
            await loadEvents()
            startPolling()
        }
    }
}

extension EventListViewModel {
    
    // MARK: - Polling
    
    /**
     Starts polling for events at regular intervals, refreshing the event list every `pollingInterval` seconds.
     */
    func startPolling() {
        isPolling = true
        timer = Timer.scheduledTimer(withTimeInterval: pollingInterval, repeats: true) { [weak self] _ in
            guard let self, self.isPolling else {
              return
            }
            Task {
                await self.loadEvents(isBackgroundRefreshList: true)
            }
        }
    }
    
    /**
     Stops polling for events by invalidating the timer and setting the `isPolling` flag to `false`.
     */
    func stopPolling() {
        isPolling = false
        timer?.invalidate()
        timer = nil
    }
}
