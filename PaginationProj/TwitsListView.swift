import SwiftUI

struct TwitsListView: View {
    @EnvironmentObject var twitsModel: TwitsModel

    var body: some View {

        NavigationView {
            List {
                if twitsModel.page == 0 {
                    ActivityIndicatorView()
                }
                ForEach(twitsModel.twitsStorage.twits) { twit in
                    TwitView(twit: twit)
                }
                if twitsModel.page != 0 {
                    ActivityIndicatorView()
                        .onAppear {
                            twitsModel.loadNextPage()
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
            .environmentObject(TwitsModel())
    }
}
