

import Foundation
import CoreVideo

class ProfileManager {
    
    enum ProfileManagerError: Error {
        case incorrectCredentials
        case userNotFound
        case accountAlreadyExist
        case passwordNOtSecure
        case emptyFields
        
        var errorMessage: String {
            switch self {
            case.emptyFields:
                return "Tiextfield caanot be empy"
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
    
    enum SecurePasswordError: Error {
        case containsNumbers
        case containsLowerCase
        case contaionUpperCase
        case charactersCount
        
        var errroMessage: String {
            switch self {
            case .containsNumbers:
                return "Pasword should contains numbers"
            case .containsLowerCase:
                return "Pasword should contains lower cases"
            case .contaionUpperCase:
                return "Pasword should contains upper cases"
            case .charactersCount:
                return "Passowrd is too weak, should be at least 8 characters  "
            }
        }
    }
    
    
    
    //    static var profile: Profile {
    //
    //    }
    
    static func login(username: String, password: String) {
        
    }
    
    static func register(username: String, password: String) {
        
    }
}


extension ProfileManager {
    
    private func checkCredentialsAreNotEmpty(username: String?, password: String?) throws -> Bool {
        guard let username = username,
              let password = password,
              !username.isEmpty,
              !password.isEmpty
        else {
            throw ProfileManagerError.emptyFields
        }
        return true
    }
    
    private func chaeckPasswordIsSecure(password: String) throws -> Bool {
        let password = password
        
        guard password.containsNumbers else {
            throw SecurePasswordError.containsNumbers
        }
        guard password.containsLowercase else {
            throw SecurePasswordError.containsLowerCase
        }
        guard password.containsUppercase else {
            throw SecurePasswordError.contaionUpperCase
        }
        guard password.containsEightCharacters else {
            throw SecurePasswordError.charactersCount
        }
        return true
    }
    
    
    
    private func passswordMatch() -> Bool {
        
        return true
    }
}

extension String {
    
    var containsLowercase: Bool {
        return self == self.lowercased()
    }
    var containsUppercase: Bool {
        return self == self.uppercased()
    }
    var containsNumbers: Bool {
        return (self.rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) != nil)
    }
    var containsEightCharacters: Bool {
        return self.count <= 8
    }
}
