
import Foundation

enum APIError: Error {
    case invalidURL
    case serializationError
    case requestError(reason: String)
    case parsingError

    var description: String {
        switch self {
        case .invalidURL:
            return "Invalid url"
        case .serializationError:
            return "Serialization error"
        case .requestError(let reason):
            return reason
        case .parsingError:
            return "Parsing error"
        }
    }
}
