import SwiftUI

struct Twit: Identifiable, Hashable {
    let userName = "@ZelenskyyUa"
    let id: String
    let twitText: String
}

extension Twit: Decodable {
    enum CodingKeys: String, CodingKey {
        case id
        case twitText = "text"
    }

    init(from decoder: Decoder) throws {
        let contaner = try decoder.container(keyedBy: CodingKeys.self)
        id = try contaner.decode(String.self, forKey: .id)
        twitText = try contaner.decode(String.self, forKey: .twitText)
    }
}
