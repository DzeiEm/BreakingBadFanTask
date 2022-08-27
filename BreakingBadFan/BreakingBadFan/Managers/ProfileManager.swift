

import Foundation
import UIKit

final class ProfileManager {
    
    static var profiles = [Profile]()
    
    
    
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
    
        
        let profile = try ValidateView.checkTextfieldsAreNotEmpty(username: username, password: password, confirmPassword: confirmPassword)

        if ValidateView.isProfileIsTaken(profile.username) {
            throw AuthenticationError.General.userAlreadyExist
        }
        
        
        try ValidateView.isPasswordSecure(password: profile.password)
        
        

        UserDefaultsHelper.saveProfile(profile)
        ProfileManager.loggedInAccount = profile
        profiles.append(profile)
    }
    
    static func login(username: String?,password: String?) throws {
        
        let profile = try ValidateView.checkTextfieldsAreNotEmpty(username: username, password: password, confirmPassword: nil)
        
        try ValidateView.isLoginCredentialsValid(profile)
        
        
        loggedInAccount = profile
    }
}
