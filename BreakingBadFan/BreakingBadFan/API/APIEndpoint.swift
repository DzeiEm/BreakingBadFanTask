

import Foundation


import Foundation

enum APIEndpoint {

    case getEpisodes
    case getQuotes
    case getCharacters
    
    var url: URL? {
        switch self {
        case .getEpisodes:
            return makeURL(endpoint: "/api/episodes")
        case .getQuotes:
            return makeURL(endpoint: "/api/quotes")
        case .getCharacters:
            return makeURL(endpoint: "/api/characters")
        }
    }

}

extension APIEndpoint {

    private var BaseUrlString: String {
        "https://www.breakingbadapi.com/api/"
    }

    private func makeURL(endpoint: String, queryItems: [URLQueryItem]? = nil) -> URL? {
        let urlString = BaseUrlString + endpoint

        var urlComponents = URLComponents(string: urlString)
        urlComponents?.queryItems = queryItems

        return urlComponents?.url
    }
}
