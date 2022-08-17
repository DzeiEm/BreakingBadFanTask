
import Foundation
import UIKit

enum SegmentTitle: String {
    case Register = "Register"
    case Login = "Login"
}

class LoginViewController: UIViewController {
    
    //OUTLETS
    @IBOutlet weak var registrationTypeSegmentController: UISegmentedControl!
    @IBOutlet weak var usernameTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var confirmPasswordTextfield: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var buttonLabel: UIButton!
    var username: String = ""
    var password: String = ""
    var confirmPassword: String = ""
    
    let ui = LoginUI()
    var profileMananager = ProfileManager()
    var loggedinUser = ProfileManager.loggedInAccount
    let homeViewController = HomeViewController()
    
    private lazy var something = {
        Bundle.main.loadNibNamed("CustomAlertView", owner: self, options: nil)?.first as? CustomAlert
    }()
    
    //ACTIONS
    @IBAction func onSegmentControllerTypeChanged(_ sender: UISegmentedControl) {
        
        if registrationTypeSegmentController.selectedSegmentIndex == 0 {
            errorLabel.isHidden = true
            hideTextfield(textfield: usernameTextfield, hide: false)
            hideTextfield(textfield: passwordTextfield, hide: false)
            hideTextfield(textfield: confirmPasswordTextfield, hide: false)
            buttonLabel.titleLabel?.text = SegmentTitle.Register.rawValue
            buttonLabel.isEnabled =  false
        } else {
            errorLabel.isHidden = true
            hideTextfield(textfield: usernameTextfield, hide: false)
            hideTextfield(textfield: passwordTextfield, hide: false)
            hideTextfield(textfield: confirmPasswordTextfield, hide: true)
            buttonLabel.titleLabel?.text = SegmentTitle.Login.rawValue
            buttonLabel.isEnabled =  false
        }
    }
    
    @IBAction func submitButtonTapped(_ sender: Any) {
        if registrationTypeSegmentController.selectedSegmentIndex == 0 {
            do {
                try ProfileManager.register(username: usernameTextfield.text, password: passwordTextfield.text, confirmPassword: confirmPasswordTextfield.text)
                
                if let loggedinUser = ProfileManager.loggedInAccount {
                    homeViewController.currentUser = loggedinUser
                    navigationController?.pushViewController(homeViewController, animated: true)
                    return
                }
            } catch let error as AuthenticationError.RegistrationError {
                
             
                
                
                //
                //                let alert = displayAlert(success: false,
                //                             title: AlertTitle.error.rawValue,
                //                             message: error?.localizedDescription ?? "",
                //                             agreeButtonTitle: AlertButton.ok.rawValue,
                //                             cancelButtonTitle: AlertButton.cancel.rawValue)
                //                present(alert, animated: true)
            }
            catch {
                print(AuthenticationError.General.unexpectedError)
            }
        }
        
        else {
            //MARK: - LOGIN USER
            do {
                try ProfileManager.login(username: usernameTextfield.text, password: passwordTextfield.text)
                
            } catch {
                let error = error as? AuthenticationError
                
            }
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        ui.roundCorners(of: buttonLabel, by: 20)
        errorLabel.isHidden = true
        buttonLabel.isEnabled = false
        usernameTextfield.delegate = self
        passwordTextfield.delegate = self
        confirmPasswordTextfield.delegate = self
    }
    override func viewDidAppear(_ animated: Bool) {
        usernameTextfield.delegate =  self
        passwordTextfield.delegate = self
        confirmPasswordTextfield.delegate = self
    }
    
}



extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        print("Textfield should begin editing")
        buttonLabel.isEnabled = true
        return true
    }
    
    private func textFieldDidBeginEditing(_ textField: UITextField) throws {
        print("textFieldDidBeginEditing")
    }
    
    private func highlightTextfield(textfield: UITextField, by: Int, _ boarderColor: UIColor) {
        textfield.layer.borderWidth = CGFloat(by)
        textfield.layer.borderColor = UIColor.red.cgColor
    }
    
    private func hideTextfield( textfield: UITextField?, hide: Bool) {
        textfield?.isHidden = hide
    }
    //
    //    func displayAlert(success: Bool,
    //                      title: String,
    //                      message: String,
    //                      agreeButtonTitle: String,
    //                      cancelButtonTitle: String ) {
    //
    //        let alertView = CustomAlert()
    //        alertView.setupView(
    //            success: success,
    //            title: title,
    //            message: message,
    //            agreeButtonTitle: agreeButtonTitle,
    //            cancelButtonTitle: cancelButtonTitle)
  
}

//extension LoginViewController {
//
//    private lazy var something = {
//        Bundle.main.loadNibNamed("CustomAlertView", owner: self, options: nil)?.first as? CustomAlert
//    }()
//}
//



