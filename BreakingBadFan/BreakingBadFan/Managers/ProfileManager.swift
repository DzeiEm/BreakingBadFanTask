

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
        
        guard let username = username,
              let password = password,
              let confirmPassword = confirmPassword
        else {
            return
        }
      
        let profile = try ValidateView.checkTextfieldsAreNotEmpty(username: username, password: password, confirmPassword: confirmPassword)
        print("USERNAME: \(profile.username)")
        print("PASSWORD: \(profile.password)")
        print("CONFIRMPASSWORD: \(profile.confirmPassword)")
        
        
        
        try ValidateView.isProfileIsTaken(profile.username)
        var isValid = try ValidateView.passwordSecure(password: profile.password)

        UserDefaultsHelper.saveProfile(profile)
        ProfileManager.loggedInAccount = profile
        profiles.append(profile)
    }
    
    static func login(username: String?,password: String?) throws {
        
        guard let username = username,
              let password = password
        else {
            return
        }
        
        let profile = try ValidateView.checkTextfieldsAreNotEmpty(username: username, password: password, confirmPassword: nil)
        
        try ValidateView.validateLoginCretentials(profile)

        loggedInAccount = profile
    }
}
