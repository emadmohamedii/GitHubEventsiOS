//
//  EventsListView.swift
//  eCabsTask
//
//  Created by Emad Habib on 12/09/2024.
//

import SwiftUI

struct EventsListView: View {
    @Environment(\.colorScheme) var colorScheme
    @StateObject private var viewModel: EventListViewModel
    @State private var hasAppeared = false
    
    init(viewModel: EventListViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Picker("Event Type", selection: $viewModel.selectedEventType) {
                    ForEach(EventType.allCases, id: \.self) { eventType in
                        Text(eventType.rawValue.capitalized)
                            .tag(eventType)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .background(Color(UIColor.systemBackground))
                .onChange(of: viewModel.selectedEventType) { newValue in
                    viewModel.setEventType(newValue)
                }
                .frame(height: 50)
                
                Divider()
                    .background(colorScheme == .dark ? .white : .black)

                Spacer()
                
                // Scrollable list content
                if viewModel.isLoading {
                    ProgressView("Loading...")
                        .progressViewStyle(CircularProgressViewStyle())
                        .padding()
                } else if let isEmpty = viewModel.isEmpty, isEmpty {
                    Text("There are currently no events to display")
                        .padding()
                    Spacer()
                } else if !viewModel.errorMessage.isEmpty {
                    Text("We're currently experiencing technical difficulties with our service.")
                        .multilineTextAlignment(.center)
                        .padding()

                    Button {
                        viewModel.retryLoadEvents()
                    } label: {
                        Text("Retry")
                            .frame(width: 100)
                            .padding(10)
                            .background(colorScheme == .dark ? .white : .black)
                            .foregroundStyle(colorScheme == .dark ? .black : .white)
                            .cornerRadius(10)
                    }
                    
                    Spacer()
                } else {
                    List(viewModel.events) { event in
                        NavigationLink(destination: EventDetailView(event: event)) {
                            EventRow(event: event)
                        }
                    }
                    .animation(.bouncy, value: viewModel.events.count)
                    .listStyle(PlainListStyle())
                }
                
                Spacer()
              
            }
            .onAppear(){
                viewModel.startPolling()
            }
            .onDisappear() {
                viewModel.stopPolling()
            }
            .navigationTitle("GitHub Events")
            .navigationBarTitleDisplayMode(.inline)
        }
        .task {
            if !hasAppeared { // once only when loading view
                await viewModel.loadEvents()
                hasAppeared = true
            }
        }
    }
}

#Preview {
    EventsListView(viewModel: DependencyInjection.resolve())
        .environmentObject(DependencyInjection.resolve())
}
