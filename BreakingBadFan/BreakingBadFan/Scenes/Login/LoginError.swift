
import Foundation


enum LoginError: Error {

    case emptyField
    case passwordDoesnotMatch
    case incorectUsernameOrPassword
    
    
    var errorMessage: String {
        switch self {
        case .emptyField:
            return "Fields cannot be empty"
        case .passwordDoesnotMatch:
            return "Password does not match"
        case .incorectUsernameOrPassword:
            return "Incorrect credentials"
        }
    }
}
