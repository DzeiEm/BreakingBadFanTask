
import Foundation


struct QuotesResponse: Decodable {
    
    let id: Int
    var quoteTitle: String?
    var author: String?
    
    enum CodingKeys: String, CodingKey {
        case id  = "quote_id"
        case quoteTitle = "quote"
        case author
    }
}
