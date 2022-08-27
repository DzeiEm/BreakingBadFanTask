import Foundation

struct APIManager {
    
    private enum HTTPMethod {
        static let get = "GET"
//        static let post = "POST"
//        static let delete = "DELETE"
    }
    
    private enum HeaderKey {
        static let headerContent = "Content-Type"
    }
    
    private enum HeaderValue {
        static let content = "application/json"
    }
    
    private var keychain: KeychainHelper { KeychainHelper() }
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
    
    private var urlSession: URLSession {
        let sessionConfiguration = URLSessionConfiguration.default
        sessionConfiguration.httpAdditionalHeaders = [
            HeaderKey.headerContent: HeaderValue.content
        ]
        return URLSession(configuration: sessionConfiguration)
    }
    
}

// MARK: - API calls

extension APIManager {
    
    func getEpisodes(completion: @escaping (Result<[Episode], APIError>) -> Void) {
        
        guard let url = APIEndpoint.getEpisodes.url else {
            completion(.failure(APIError.invalidURL))
            return
        }
        urlSession.dataTask(with: url, completionHandler: { data, _, error in
            if let error = error {
                completion(.failure(APIError.requestError(reason: error.localizedDescription)))
                return
            }
            guard let data = data,
                  let allEpisodes = try? decoder.decode([EpisodeResponse].self, from: data)
            else {
                completion(.failure(APIError.parsingError))
                return
            }
            completion(.success(allEpisodes.compactMap { episode in
                Episode(id: episode.id,
                        title: episode.title,
                        season: episode.season,
                        airDate: episode.airDate,
                        characters: episode.characters)
            }))
        }).resume()
    }
    
    
    func getQuotes(completion: @escaping (Result<[Quote], APIError>) -> Void) {
        guard let url = APIEndpoint.getQuotes.url else {
            completion(.failure(APIError.invalidURL))
            return
        }
        urlSession.dataTask(with: url, completionHandler: { data, _, error in
            if let error = error {
                completion(.failure(APIError.requestError(reason: error.localizedDescription)))
                return
            }
            guard let data = data,
                  let allQuotes = try? decoder.decode([QuotesResponse].self, from: data)
            else {
                completion(.failure(APIError.parsingError))
                return
            }
            completion(.success(allQuotes.compactMap({ quote in
                Quote(id: quote.id, header: quote.quoteTitle, author: quote.author)
            })))
        }).resume()
    }
    
    func getCharacters(completion: @escaping (Result<[Character], APIError>) -> Void) {
        guard let url = APIEndpoint.getCharacters.url else {
            completion(.failure(APIError.invalidURL))
            return
        }
        urlSession.dataTask(with: url, completionHandler: { data, _, error in
            if let error = error {
                completion(.failure(APIError.requestError(reason: error.localizedDescription)))
                return
            }
            guard let data = data,
                  let allCharacters = try? decoder.decode([CharactersResponse].self, from: data)
            else {
                completion(.failure(APIError.parsingError))
                return
            }
            completion(.success(allCharacters.compactMap({ character in
                Character(id: character.id,
                          name: character.name,
                          birthday: character.birthday,
                          occupation: [character.birthday],
                          status: character.status,
                          appearance: character.appearance,
                          nickname: character.nickname,
                          portrayed: character.portrayed)
            })))
        }).resume()
    }
}
                                
                                
