//
//  EventRow.swift
//  eCabsTask
//
//  Created by Emad Habib on 13/09/2024.
//

import SwiftUI

struct EventRow: View {
    let event: GitHubEvent
    
    var body: some View {
        HStack {
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
                .frame(width: 40, height: 40)
                .clipShape(Circle())
            }
            
            Text(event.actor.displayLogin)
                .font(.headline)
        }
    }
}
