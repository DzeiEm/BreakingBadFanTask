
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
    let profileMananager = ProfileManager()
    let loggedinUser = ProfileManager.loggedInAccount
    
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
        let homeViewController = HomeViewController()
        
        if registrationTypeSegmentController.selectedSegmentIndex == 0 {
            do {
                username = usernameTextfield.text ?? ""
                password = passwordTextfield.text ?? ""
                confirmPassword = confirmPasswordTextfield.text ?? ""
                
                try ProfileManager.register(username: usernameTextfield.text, password: passwordTextfield.text, confirmPassword: confirmPasswordTextfield.text)
                
                present(homeViewController, animated: true, completion: nil)
                return
            } catch {
                let error = error as?  ProfileManager.LoginError
                
                displayAlert(username: username, password: password, comfirmPassword: confirmPassword, messsage: error?.errorMessage ?? "" )
                return
            }
        } else {
            do {
                try ProfileManager.login(username: usernameTextfield.text, password: passwordTextfield.text)
                present(homeViewController, animated: true, completion: nil)
                return
            } catch {
                let error = error as?  ProfileManager.LoginError
                
                displayAlert(username: username, password: password, comfirmPassword: confirmPassword, messsage: error?.errorMessage ?? "" )
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
}


