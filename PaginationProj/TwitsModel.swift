import SwiftUI

class TwitsModel: ObservableObject {
    enum DataFailures: Error {
        case decodeError
        case fatchingError
    }
    
    let twitsStorage = TwitsStorge()

    var baseURLString = "https://api.twitter.com/2/tweets/search/recent"
    var bearerToken = "AAAAAAAAAAAAAAAAAAAAANU0iAEAAAAAYsEzi7qN4ePnKtIBcvtLxhdV9Yg%3Dd7yJp1S2pClfJNTs6baLnAm6X7qntTgLaw6DXNlafsTDdYsUo6"
    var baseParams = [
        "query": "from: ZelenskyyUa"
    ]
    
    var maxResults = "10"
    var page = 0
    var offset: Int { page * (Int(maxResults) ?? 0) }


    func loadNextPage() {
        if twitsStorage.twits.count <= offset {
            baseParams["pagination_token"] = twitsStorage.nextToken
            baseParams["max_results"] = maxResults
//            fetchContents()
        }
    }

    //MARK: Paggination

    func fetchContents(completion: (Result<TwitsStorge, DataFailures>) -> Void) throws {
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
                    let result = try decoder.decode(TwitsStorge.self, from: data)
                    completion(.success(result))
                }
                catch DataFailures.decodeFailure {
                    print("Error")
                }
                return
            } else {
                completion(.failure(DataFailures.fatchingError))
            }

        }
        .resume()
    }


    init() {
        try! fetchContents() { result in
            switch result {
            case .success(let storage):
                twitsStorage.twits = storage.get().twits
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
