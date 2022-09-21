
import UIKit

struct EpisodeResponse: Decodable {
    let id: Int
    let title: String
    let season: String
    let episode: String
    let airDate: String
    let characters: [String]
   
    enum CodingKeys: String, CodingKey {
        case id = "episode_id"
        case title
        case season
        case episode
        case airDate = "air_date"
        case characters
    }
}


