import SwiftUI

@main
struct PaginationProjApp: App {
    @StateObject private var twitsModel = TwitsModel()

    var body: some Scene {
        WindowGroup {
            TwitsListView()
                .environmentObject(twitsModel)
        }
    }
}
