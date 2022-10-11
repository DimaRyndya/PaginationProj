import SwiftUI

struct TwitView: View {

    let twit: Twit

    var body: some View {
        VStack {
            Text(twit.id)
                .font(.headline)
            Text(twit.twitText)
                .font(.subheadline)
        }
    }
}

struct TwitView_Previews: PreviewProvider {
    static var previews: some View {
        TwitView(twit: Twit(id: "1", twitText: "dfsdf"))
    }
}
