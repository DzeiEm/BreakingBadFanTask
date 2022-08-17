import UIKit

typealias AlertCompletion = (UIButton) -> Void

protocol CustomAlertViewDelegate: AnyObject {
    func didTapCancelButton()
    func didTapAgreeButton()
}

enum AlertButton: String {
    case ok = "OK"
    case cancel = "Cancel"
}
enum AlertTitle: String {
    case error =  "ERROR 😬"
    case success = "SUCCESS 🤟🏻"
}

final class CustomAlert: UIView {
    
    @IBOutlet weak var alertHeader: UILabel!
    @IBOutlet weak var alertMessage: UILabel!
    @IBOutlet weak var agreeButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    
    var completion: AlertCompletion?
    weak var delegate: CustomAlertViewDelegate?
    
    func setupView(success: Bool,
                   title: String,
                   message: String,
                   agreeButtonTitle: String,
                   cancelButtonTitle: String,
                   completion: AlertCompletion? = nil) {
        
        alertHeader.text = title
        alertMessage.text = message
        agreeButton.setTitle(agreeButtonTitle, for: .normal)
        cancelButton.setTitle(cancelButtonTitle, for: .normal)
        
        if success {
            self.backgroundColor = .green
        } else {
            self.backgroundColor = .red
        }
        
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.cornerRadius = 4
        
        self.completion = completion
    }
    
    
    @IBAction func agreeButtonTapped() {
        completion?(agreeButton)
        removeFromSuperview()
        delegate?.didTapAgreeButton()
    }
    
    @IBAction func cancelButtonTapped() {
        completion?(cancelButton)
        removeFromSuperview()
        delegate?.didTapCancelButton()
    }
    
    func setButtonColor(_ button: UIButton) {
        
    switch button {
        case agreeButton: button.backgroundColor = .green
        case cancelButton: button.backgroundColor  = .red
        default:
            button.backgroundColor = .systemGreen
        }
        return
    }
}

