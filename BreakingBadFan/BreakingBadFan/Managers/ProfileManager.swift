

import Foundation
import UIKit

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
    
    static var loggedInAccount: Profile? {
        willSet(newProfile) {
            print("About to set username", newProfile?.username ?? "nil" )
        }
        didSet {
            print("About to set username", loggedInAccount?.username ?? "nil" )
        }
    }
    
    static func register(username: String?, password: String?) throws {
        
        
        let profile = try checkCredentialsAreNotEmpty(username: username, password: password)
        
        guard try cheackIsPasswordSecure(password: profile.password) else {
            throw ProfileManagerError.passwordNOtSecure
        }
        
        guard try checkIsUsernameUnique(username: profile.username) else {
            throw ProfileManagerError.accountAlreadyExist
        }
        
        UserDefaultsHelper.saveProfile(profile)
        loggedInAccount = profile
        
    }
    
    static func login(username: String, password: String) {
        
    }
}


extension ProfileManager {
    
    private static func checkCredentialsAreNotEmpty(username: String?, password: String?) throws -> Profile {
        guard let username = username,
              let password = password,
              !username.isEmpty,
              !password.isEmpty
        else {
            throw ProfileManagerError.emptyFields
        }
        return Profile(username: username, password: password)
    }
    
    private static func checkIsUsernameUnique(username: String) throws -> Bool {
        return UserDefaultsHelper.profiles?.contains(where: { profile in
            profile.username == username
        }) ?? false
    }
    
    private static func cheackIsPasswordSecure(password: String) throws -> Bool {
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
    
    private static func passswordsMatches(_ profile: Profile) -> Bool {
        guard let neededAccount = UserDefaultsHelper.profiles?.first(where: { neededAccount in
            neededAccount.username == profile.username
        }) else {
            return false
        }
        return KeychainHelper.getPasword(usernameKey: neededAccount.username) == profile.password
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
