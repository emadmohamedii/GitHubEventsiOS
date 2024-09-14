//
//  EventType.swift
//  eCabsTask
//
//  Created by Emad Habib on 12/09/2024.
//

import Foundation

 enum EventType: String, CaseIterable {
    case none = "All"
    case watch = "WatchEvent"
    case pullRequest = "PullRequestEvent"
    case gollum = "GollumEvent"
    case fork = "ForkEvent"
    case delete = "DeleteEvent"
    
    var title:String {
        switch self {
        case .none: "Filter By Event Type"
        case .watch: "Watch Event"
        case .pullRequest: "Pull Request Event"
        case .gollum: "Gollum Event"
        case .fork: "Fork Event"
        case .delete: "Delete Event"
        }
    }
}
