import SwiftUI

final class TwitsStorge: Decodable, ObservableObject {
    @Published var twits: [Twit] = []
    @Published var isLoadingPage = false

    var baseURLString = "https://api.twitter.com/2/tweets/search/recent"
    var bearerToken = "AAAAAAAAAAAAAAAAAAAAANU0iAEAAAAAYsEzi7qN4ePnKtIBcvtLxhdV9Yg%3Dd7yJp1S2pClfJNTs6baLnAm6X7qntTgLaw6DXNlafsTDdYsUo6"
    var baseParams = [
        "query": "from: ZelenskyyUa"
    ]
    var nextToken = ""


    func loadNextPage() {
        if nextToken != "" {
            baseParams["pagination_token"] = nextToken
        }
        fetchContents()
    }

    //MARK: Paggination


    func fetchContents() {
        isLoadingPage = true
        guard var urlComponents = URLComponents(string: baseURLString) else { return }
        urlComponents.setQueryItems(with: baseParams)
        guard let contentsURL = urlComponents.url else { return }
        var request = URLRequest(url: contentsURL)
        request.httpMethod = "GET"
        request.addValue("Bearer " + bearerToken, forHTTPHeaderField: "Authorization")

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data,
               let response = response as? HTTPURLResponse {
                print(response.statusCode)
                if let decodedResponse = try? JSONDecoder().decode(TwitsStorge.self, from: data) {
                    DispatchQueue.main.async {
                        self.twits = decodedResponse.twits
                        self.nextToken = decodedResponse.nextToken
                        print(self.nextToken)
                        self.isLoadingPage = false
                    }
                    return
                }
            }
            print(
                "Contents fetch failed: " +
                "\(error?.localizedDescription ?? "Unknown error")")
        }
        .resume()
    }

    init() {
        fetchContents()
    }

    //MARK: Decoding TwitsStorage

    enum CodingKeys: String, CodingKey {
        case twits = "data"
        case meta
    }

    enum MetaKeys: String, CodingKey {
        case nextToken = "next_token"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        twits = try container.decode([Twit].self, forKey: .twits)
        let metaContainer = try container.nestedContainer(keyedBy: MetaKeys.self, forKey: .meta)
        nextToken = try metaContainer.decode(String.self, forKey: .nextToken)
    }

}


