import SwiftUI

struct TwitsListView: View {
    @StateObject private var twitsModel = TwitsViewModel()

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack {
                    ForEach(twitsModel.twitStorage.twits) { twit in
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
