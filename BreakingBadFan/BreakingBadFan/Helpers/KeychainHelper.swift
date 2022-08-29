
import Foundation
import KeychainSwift

class KeychainHelper {
    
    static var keychain = KeychainSwift()
    
    static func savePassword(profile: Profile) {
        keychain.set(profile.username, forKey: profile.password)
    }
    
    static func getPasword(usernameKey: String) -> String? {
        keychain.get(usernameKey)
    }
}

