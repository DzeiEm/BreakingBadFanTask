
import Foundation

struct CharactersResponse: Decodable {
    let id: Int
    let name: String
    let birthday: String
    let occupation: [String]
    let status: String
    let appearance: [Int]
    let nickname: String
    let portrayed: String
    
    enum CodingKeys: String, CodingKey {
        case id = "char_id"
        case name
        case birthday
        case occupation
        case status
        case appearance
        case nickname
        case portrayed
    }
}
