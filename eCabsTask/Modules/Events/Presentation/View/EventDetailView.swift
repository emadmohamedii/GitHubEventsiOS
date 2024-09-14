//
//  EventDetailView.swift
//  eCabsTask
//
//  Created by Emad Habib on 13/09/2024.
//

import SwiftUI

struct EventDetailView: View {
    let event: GitHubEvent
    
    var body: some View {
        VStack {
            if let avatarUrl = event.actor.avatarUrl {
                AsyncImage(url: URL(string: avatarUrl)) { image in
                    image.resizable()
                        .scaledToFill()
                } placeholder: {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.gray)
                }
                .frame(width: 100, height: 100)
                .clipShape(Circle())
            }

            Text(event.actor.displayLogin)
                .font(.headline)

            Group {
                Text(event.createdAt)
                Text(event.type)
                Text("Repo Name: \(event.repo.name)")
            }
            .font(.subheadline)
            .padding(.horizontal)
            
            Spacer()
        }
        .navigationTitle("Event Details")
    }
}
