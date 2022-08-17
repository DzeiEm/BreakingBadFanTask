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

final class CustomAlertView: UIView {
    
    @IBOutlet private weak var alertHeader: UILabel!
    @IBOutlet private weak var alertMessage: UILabel!
    @IBOutlet private weak var agreeButton: UIButton!
    @IBOutlet private weak var cancelButton: UIButton!
   
    
    var completion: AlertCompletion?
    weak var delegate: CustomAlertViewDelegate?
    var profileManager = ProfileManager()
   
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
    
}
