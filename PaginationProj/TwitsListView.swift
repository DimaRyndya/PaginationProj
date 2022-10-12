import SwiftUI

struct TwitsListView: View {
    @StateObject private var storage = TwitsStorge()

    var body: some View {
        NavigationView {
            List {
                ForEach(storage.twits) { twit in
                    TwitView(twit: twit)
                }
                ActivityIndicatorView()
                    .onAppear {
                        storage.loadNextPage()
                    }
            }
            .navigationTitle("Twits")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TwitsListView()
    }
}
