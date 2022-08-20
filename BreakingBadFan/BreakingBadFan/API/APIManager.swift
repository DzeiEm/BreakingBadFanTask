import Foundation

struct APIManager {
    
    private enum HTTPMethod {
        static let get = "GET"
        static let post = "POST"
        static let delete = "DELETE"
    }
    
 
    private var urlSession: URLSession {
        let sessionConfiguration = URLSessionConfiguration.default
        return URLSession(configuration: sessionConfiguration)
    }
    
    private var keychain: KeychainHelper { KeychainHelper() }
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
    
  
}

// MARK: - API calls

extension APIManager {
    
}
