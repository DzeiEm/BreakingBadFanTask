
import UIKit

final class AlertView {
    
    static func build(
        title: String? = "Alert!",
        message: String,
        completion: (() -> Void)? = nil) -> UIAlertController {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        let alertButton = UIAlertAction(
            title: "OK",
            style: .default
        ) { _ in
            completion?()
        }
        alert.addAction(alertButton)
        alert.view.backgroundColor = .red
            alert.view.layer.cornerRadius = 4
            alert.view.layer.borderWidth = 2
        return alert
    }
    
   
}

