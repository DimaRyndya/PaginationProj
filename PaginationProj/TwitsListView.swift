import SwiftUI

struct TwitsListView: View {
    @EnvironmentObject var storage: TwitsStorge

    var body: some View {
        NavigationView {
            List {
                ForEach(storage.twits) { twit in
                    TwitView(twit: twit)
                }
                if storage.page != 0 {
                    ActivityIndicatorView()
                        .onAppear {
                            storage.loadNextPage()
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
            .environmentObject(TwitsStorge())
    }
}
