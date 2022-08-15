
import Foundation
import UIKit



enum AlertActions: String {
    case ok = "Ok"
    case cancel = "Cancel"
}

enum AlertTitle: String {
    case success = "Success"
    case failure = "Ooops"
}

enum AlertMessage: String {
    case allGood = "Sucess messsage"
    case notGood = "Nopt good"
    case general = "Unexpected error appears"
}


class AlertView: UIViewController {
   
    
    static func makeAlert(isSucceess: Bool, title: String, message: String) -> UIAlertController {
        var alert = UIAlertController()
        if isSucceess {
            alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: AlertActions.ok.rawValue, style: .default))
            return alert
        }
        alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: AlertActions.ok.rawValue, style: .default))
        alert.addAction(UIAlertAction(title: AlertActions.cancel.rawValue, style: .cancel))
        return alert
    }
}
