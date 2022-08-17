

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
        var profile: Profile
        
        guard let username = username,
              let password = password,
              let confirmPassword = confirmPassword
        else {
            return
        }
        
        profile = try ValidateView.checkTextfieldsAreNotEmpty(username: username, password: password, confirmPassword: confirmPassword)
    
        try ValidateView.passwordMatch(password: password, confirmPassword: confirmPassword)

        try ValidateView.isProfileIsTaken(username)

        UserDefaultsHelper.saveProfile(profile)
        ProfileManager.loggedInAccount = profile
        profiles.append(profile)
    }
    
    static func login(username: String?,password: String?) throws {
//        let profile = try checkCredentialsAreNotEmpty(username: username, password: password, confirmPassword: nil)
//
//        guard let username = username else {
//            return
//        }
//
//        guard profileIsTaken(username) else {
//            throw LoginError.userNotFound
//        }
//
//        guard try validateLoginCredentials(profile) else {
//            throw LoginError.incorrectCredentials
//        }
//
//        loggedInAccount = profile
    }
}
