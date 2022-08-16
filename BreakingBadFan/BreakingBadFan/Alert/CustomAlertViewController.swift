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

final class CustomAlertViewController: UIView {
    
    @IBOutlet weak var alertHeader: UILabel!
    @IBOutlet weak var alertMessage: UILabel!
    
    @IBOutlet weak var agreeButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    

    var completion: AlertCompletion?
    weak var delegate: CustomAlertViewDelegate?

    func buildView(title: String,
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

