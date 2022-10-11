import SwiftUI

struct TwitsListView: View {
    @StateObject private var storage = TwitsStorge()

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack {
                    ForEach(storage.twits) { twit in
                        TwitView(twit: twit)
                    }
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
