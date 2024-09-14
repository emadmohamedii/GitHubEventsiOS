# GitHub Events iOS App

This project is an iOS application built using SwiftUI and Clean Architecture principles. It fetches and displays GitHub events from the GitHub RESTful API, utilizing modern Swift features such as `async/await`, MVVM architecture, and dependency injection.

---

## Features
- Displays a list of GitHub events using SwiftUI Views.
- Supports **dark mode** and **multiple device orientations**.
- Handles **loading states**, **error states**, and **empty states**.
- Includes a **retry mechanism** for fetching events when a network failure occurs.
- Filters events by type and updates the event list every 10 seconds using a polling mechanism.

## Architecture

The app follows **Clean Architecture** and **MVVM (Model-View-ViewModel)** principles to ensure high testability, scalability, and maintainability. It is divided into the following layers:

### Layers:
1. **Domain Layer**: Contains the core business logic, including entities and use cases.
    - Example: `FetchEventListUseCase.swift` fetches the list of GitHub events from the repository.
   
2. **Data Layer**: Responsible for fetching and providing data, typically from an API.
    - Example: `EventListRepository.swift` interacts with the GitHub API.

3. **Presentation Layer**: Consists of **ViewModels** and **SwiftUI Views**. The ViewModel handles the business logic and binds data to the views.
    - Example: `EventListViewModel.swift` manages the event data, loading states, and error handling for the UI.

### Dependency Injection
The app uses **Resolver** for dependency injection, which helps in keeping the code loosely coupled and facilitates better testability by enabling easy mocking of components.


## Usage

- The app fetches GitHub events and displays them in a list.
- You can filter events by type using the Picker at the top of the list.
- The app automatically refreshes the event list every 10 seconds.


## Technologies

* Swift 6
* SwiftUI
* Clean Architecture
* MVVM
* Dependency Injection (Resolver)
* GitHub RESTful API
* Unit Testing with XCTest


## Contributions

Private!
