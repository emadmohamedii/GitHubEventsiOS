//
//  EventListRouter.swift
//  eCabsTask
//
//  Created by Emad Habib on 12/09/2024.
//

import CoreNetwork

/**
 `EventListRouter` defines the endpoints and request configurations for fetching GitHub events from the GitHub API.
 The router conforms to the `APIRouter` protocol, specifying the host, path, request method, headers, and optional body required for the request.
 
 Usage:
 ```swift
 let router = EventListRouter.eventList
*/

enum EventListRouter : APIRouter {
    
    /// Specifies the API endpoint for fetching a list of events.
    case eventList
    
    /// The relative path for the GitHub events API.
    var path: String {
        return "events"
    }
    
    /// The base URL for the GitHub API.
    var host: String {
        return "https://api.github.com"
    }
    
    /// The HTTP method used for the request.
    var method: RequestMethod {
        return .get
    }
    
    /// The request headers, including content type.
    var header: [String : String]? {
        return ["Content-Type": "application/json"]
    }
    
    /// The body of the request (not used in this case, hence `nil`).
    var body: [String : String]? {
        return nil
    }
}
