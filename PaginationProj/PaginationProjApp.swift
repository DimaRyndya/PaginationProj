import SwiftUI

@main
struct PaginationProjApp: App {
    @StateObject private var storage = TwitsStorge()

    var body: some Scene {
        WindowGroup {
            TwitsListView()
                .environmentObject(storage)
        }
    }
}
