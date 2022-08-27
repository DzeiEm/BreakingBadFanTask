
import Foundation



class LoginValidation {
    
    let profileManager = ProfileManager()
    
    
    static func checkIsTextfieldIsEmpty(username: String?, password: String?) throws -> Profile {
        
        guard let username = username,
              let password = password,
              !username.isEmpty,
              !password.isEmpty
        else {
            throw AuthenticationError.General.emptyFields
        }
        return Profile(username: username, password: password, confirmPassword: nil)

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
