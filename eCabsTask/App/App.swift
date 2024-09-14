import SwiftUI

@main
struct eCabsTask: App {
    var body: some Scene {
        WindowGroup {
            EventsListView(viewModel: DependencyInjection.resolve())
        }
    }
}
