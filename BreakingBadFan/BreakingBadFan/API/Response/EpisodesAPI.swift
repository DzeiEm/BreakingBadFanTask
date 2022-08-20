
import Foundation

struct EpisodesResponse: Decodable {
    
    let id: Int
    let title: String
    let season: Int
    let episode: Int
    let airDate: String
    let characters: [Array]
    let series: String
    
    
    
}
