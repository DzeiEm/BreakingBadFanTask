
import UIKit

struct EpisodesResponse: Decodable {
    
    let id: Int
    let title: String
    let season: Int
    let episode: Int
    let airDate: String
    let characters: [String]
    let series: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case season
        case episode
        case airDate = "air_date"
        case characters
        case series
    }
}
