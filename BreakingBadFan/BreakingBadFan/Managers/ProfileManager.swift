

import Foundation

class ProfileManager {
    
    enum ProfileManagerError: Error {
        case incorrectCredentials
        case userNotFound
        case accountAlreadyExist
        case passwordNOtSecure
        
        var errorMessage: String {
            switch self {
            case .incorrectCredentials:
                return "Username or password incorrect"
            case .userNotFound:
                return "User not found, check your credentials"
            case .accountAlreadyExist:
                return "Account already exist"
            case .passwordNOtSecure:
                return "Password is weak,try to create stronger"
            }
        }
        
    }
    
    static func login(username: String, password: String) {
        
    }
    
    static func register(username: String, password: String) {
        
    }
    
}
