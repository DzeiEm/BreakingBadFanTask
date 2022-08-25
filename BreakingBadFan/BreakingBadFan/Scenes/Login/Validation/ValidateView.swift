
import Foundation

class ValidateView {
    
    let profileManager = ProfileManager()
   
    static func checkTextfieldsAreNotEmpty(
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
                throw AuthenticationError.General.emptyFields
                }
            return Profile(username: username, password: password, confirmPassword: confirmPassword)
        }
    
    static func passwordMatch(password: String?, confirmPassword: String?) throws -> Bool {
        
        if password != confirmPassword {
            throw AuthenticationError.RegistrationError.passwordDoNotMatch
        }
        return true
    }
    
    static func isPasswordSecure(password: String) throws  {
        
        guard containsNumbers(password) else {
            throw AuthenticationError.Secure.containsNumbers
        }
        guard containsLowerCase(password) else {
            throw AuthenticationError.Secure.containsLowerCases
        }
        guard containsUpperCase(password) else {
            throw AuthenticationError.Secure.containsUpperCases
        }
        guard containsRequiredPasswordLength(password) else {
            throw AuthenticationError.Secure.containsRequiredPasswordLength
        }
    }
    
    static func isProfileIsTaken(_ username: String) -> Bool {
        return UserDefaultsHelper.profiles?.contains(where: { profile in
            profile.username == username
        }) ?? false
    }
    
    static func validateLoginCretentials(_ profile: Profile) throws -> Bool {
        guard let neededAccount = UserDefaultsHelper.profiles?.first(where: { neededAccount in
            neededAccount.username == profile.username
        }) else {
            return false
        }
        return KeychainHelper.getPasword(usernameKey: neededAccount.username) == profile.password
    }
}

extension ValidateView {
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
