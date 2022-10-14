//import SwiftUI
//
//final class TwitsStorge: Decodable, ObservableObject {
//
//
//
//    var nextToken = ""

    //MARK: Decoding TwitsStorage


//
//}


//            guard let data = data else {
//                if let urlError = error as? URLError {
//                    completion(.failure(urlError))
//                    return
//                }
//                assertionFailure("Data and error should never both be nil")
//            }
//
//            let decoder = JSONDecoder()
//
//            let result = Result(catching: {
//                try decoder.decode(TwitsStorge.self, from: data)
//            })
//
//            completion(result)


//            if let data = data,
//               let response = response as? HTTPURLResponse {
//                completion(.success(data))
//                print(response.statusCode)
//                if let decodedResponse = try? JSONDecoder().decode(TwitsStorge.self, from: data) {
//                    DispatchQueue.main.async {
//
//                        self.twits += decodedResponse.twits
//                        self.nextToken = decodedResponse.nextToken
//                        self.page += 1
//                    }
//                    return
//                }
//            }
//            print(
//                "Contents fetch failed: " +
//                "\(error?.localizedDescription ?? "Unknown error")")

