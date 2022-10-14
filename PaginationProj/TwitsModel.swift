import SwiftUI

final class TwitsModel: ObservableObject, Decodable {

    enum NetworkFailure: Error {
        case decodeError
    }

    @Published var twits: [Twit] = []

    @Published var isLoading = false

    var baseURLString = "https://api.twitter.com/2/tweets/search/recent"
    var bearerToken = "AAAAAAAAAAAAAAAAAAAAANU0iAEAAAAAYsEzi7qN4ePnKtIBcvtLxhdV9Yg%3Dd7yJp1S2pClfJNTs6baLnAm6X7qntTgLaw6DXNlafsTDdYsUo6"
    var baseParams = [
        "query": "from: ZelenskyyUa"
    ]
    var nextToken = ""
    var maxResults = "10"

    func loadNextPage() {
        fetchTwits() { result in
            switch result {
            case .success(let storage):
                self.baseParams["pagination_token"] = self.nextToken
                self.baseParams["max_results"] = self.maxResults
                self.twits += storage.twits
                self.nextToken = storage.nextToken
            case .failure(let error):
                print("\(error)")
                self.isLoading = false
            }
        }
    }

    //MARK: Paggination

    func fetchTwits(completion: @escaping (Result<TwitsModel, NetworkFailure>) -> Void) {
        guard var urlComponents = URLComponents(string: baseURLString) else { return }
        urlComponents.setQueryItems(with: baseParams)
        guard let contentsURL = urlComponents.url else { return }
        var request = URLRequest(url: contentsURL)
        request.httpMethod = "GET"
        request.addValue("Bearer " + bearerToken, forHTTPHeaderField: "Authorization")

        URLSession.shared.dataTask(with: request) { data, response, _ in
            if let data = data,
               let response = response as? HTTPURLResponse {
                print(response.statusCode)
                do {
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(TwitsModel.self, from: data)
                    completion(.success(result))
                }
                catch {
                    completion(.failure(NetworkFailure.decodeError))
                }
                return
            }
        }
        .resume()
    }


    init() {
        fetchTwits() { [weak self] result in
            switch result {
            case .success(let storage):
                self?.twits = storage.twits
                self?.nextToken = storage.nextToken
                self?.isLoading = true
            case .failure(let error):
                print(error)
            }
        }
    }

    //MARK: Decoding TwitsModel

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
