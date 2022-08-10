
import Foundation


class Profile: Codable {
    var username: String
    var password: String
    var confirmPassword: String?
    
    init(username: String, password: String) {
        self.username = username
        self.password = password
//        self.confirmPassword = nil
    }
}
