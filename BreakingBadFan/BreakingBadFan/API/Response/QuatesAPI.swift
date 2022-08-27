
import Foundation


struct QuotesResponse: Decodable {
    
    let id: Int
    let quoteTitle: String
    let author: String
    
    enum CodingKeys: String, CodingKey {
        case id  = "quote_id"
        case quoteTitle
        case author
    }
}
