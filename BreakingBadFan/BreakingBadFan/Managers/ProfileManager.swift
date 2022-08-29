

import Foundation
import UIKit

final class ProfileManager {
    
    static var profiles = [Profile]()
    
    static var loggedInAccount: Profile? {
        willSet(newProfile) {
            print("About to set username", newProfile?.username ?? "nil" )
        }
        didSet {
            print("About to set username", loggedInAccount?.username ?? "nil" )
        }
    }
    
    static func register(username: String?, password: String?, confirmPassword: String?) throws {
    
        
        let profile = try RegistrationValidation.checkTextfieldsAreNotEmpty(username: username, password: password, confirmPassword: confirmPassword)

        if RegistrationValidation.isProfileIsTaken(profile.username) {
            throw AuthenticationError.General.userAlreadyExist
        }
        
        try RegistrationValidation.isPasswordSecure(password: profile.password)
        try RegistrationValidation.isPasswordMatch(password: profile.password, confirmPassword: profile.confirmPassword)
        
        UserDefaultsHelper.saveProfile(profile)
        ProfileManager.loggedInAccount = profile
        profiles.append(profile)
    }
    
    static func login(username: String?,password: String?) throws {
        
        let profile = try LoginValidation.checkIsTextfieldIsEmpty(username: username, password: password)
        
        try LoginValidation.isLoginCredentialsValid(profile)
        
        loggedInAccount = profile
    }
}
