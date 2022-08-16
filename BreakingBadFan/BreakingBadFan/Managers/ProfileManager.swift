

import Foundation
import UIKit

final class ProfileManager {
    
    enum LoginError: Error {
        case incorrectCredentials
        case passwordDoesNotMatch
        case userNotFound
        case accountAlreadyExist
        case weakPassword
        case emptyFields
    
        var errorMessage: String {
            switch self {
            case.emptyFields:
                return "Tiextfields caanot be empty "
            case .incorrectCredentials:
                return "Username or password incorrect"
            case .userNotFound:
                return "User not found, check your credentials"
            case .accountAlreadyExist:
                return "Account already exist"
            case .weakPassword:
                return "Password is weak,try to create stronger"
            case .passwordDoesNotMatch:
                return "Password does not match"
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
                return "Pasword should contains numbers "
            case .containsLowerCase:
                return "Pasword should contains lower cases"
            case .contaionUpperCase:
                return "Pasword should contains upper cases"
            case .charactersCount:
                return "Passowrd is too weak, should be at least 8 characters  "
            }
        }
    }
    
    //MARK: -Variables
    static var loggedInAccount: Profile? {
        willSet(newProfile) {
            print("About to set username", newProfile?.username ?? "nil" )
        }
        didSet {
            print("About to set username", loggedInAccount?.username ?? "nil" )
        }
    }
    
    //MARK:- Public functions
    static func register(username: String?, password: String?, confirmPassword: String?) throws {
        
        let profile = try checkCredentialsAreNotEmpty(username: username, password: password, confirmPassword: confirmPassword)
        
        guard try checkDoesPasswordMatch(password: profile.password, confirmPassword: profile.confirmPassword ?? "") else {
            throw LoginError.passwordDoesNotMatch
        }
//        guard try checkIsUsernameUnique(username: profile.username) else {
//            throw LoginError.accountAlreadyExist
//        }
        
        UserDefaultsHelper.saveProfile(profile)
        ProfileManager.loggedInAccount = profile
        UsersDatabase.profiles.append(profile)
    }
    
    static func login(username: String?,password: String?) throws {
        let profile = try checkCredentialsAreNotEmpty(username: username, password: password, confirmPassword: nil)
        
        guard let username = username else {
            return
        }
        
        guard profileIsTaken(username) else {
            throw LoginError.userNotFound
        }
        
        guard try loginPassswordsMatches(profile) else {
            throw LoginError.incorrectCredentials
        }
        
        loggedInAccount = profile
    }
}

extension ProfileManager {
    
    static private func checkCredentialsAreNotEmpty(
        username: String?,
        password: String?,
        confirmPassword: String?) throws -> Profile {
            
            guard let username = username,
                  let password = password,
                  let confirmPassword = confirmPassword,
                  !username.isEmpty,
                  !password.isEmpty,
                  !confirmPassword.isEmpty
            else {
                throw LoginError.emptyFields
            }
            return Profile(username: username, password: password, confirmPassword: confirmPassword)
        }
    
    static private func checkIsUsernameUnique(username: String) throws -> Bool {
        return UserDefaultsHelper.profiles?.contains(where: { profile in
            profile.username == username
        }) ?? false
    }
    
   
    static private func loginPassswordsMatches(_ profile: Profile) throws -> Bool {
        guard let neededAccount = UserDefaultsHelper.profiles?.first(where: { neededAccount in
            neededAccount.username == profile.username
        }) else {
            return false
        }
        return KeychainHelper.getPasword(usernameKey: neededAccount.username) == profile.password
    }
    
    static func checkDoesPasswordMatch(password: String, confirmPassword: String) -> Bool {
        
        if password == confirmPassword  {
            return true
        }
        return false
    }
    
    static func profileIsTaken(_ username: String) -> Bool {
        return UserDefaultsHelper.profiles?.contains(where: { profile in
            profile.username == username
        }) ?? false
    }
    static func cheackIsPasswordSecure(password: UITextField) throws -> Bool {
        guard let password = password.text else {
            return false
        }
        guard ProfileManager.containsNumbers(password) else {
            throw SecurePasswordError.containsNumbers
        }
        guard ProfileManager.containsLowerCase(password) else {
            throw SecurePasswordError.containsLowerCase
        }
        guard ProfileManager.containsUpperCase(password) else {
            throw SecurePasswordError.contaionUpperCase
        }
        guard ProfileManager.containsRequiredPasswordLength(password) else {
            throw SecurePasswordError.charactersCount
        }
        return true
    }
}

extension ProfileManager {
    
    private static func containsUpperCase(_ password: String) -> Bool {
        password.contains(where: { letter in
            letter.isUppercase
        })
    }
    
    private static func containsLowerCase(_ password: String) -> Bool {
        password.contains(where: { letter in
            letter.isLowercase
        })
    }
    
    private static func containsNumbers(_ password: String) -> Bool {
        password.contains(where: { letter in
            letter.isNumber
        })
    }
    private static func containsRequiredPasswordLength(_ password: String) -> Bool {
        password.count >= 8 ? true : false
    }
}

