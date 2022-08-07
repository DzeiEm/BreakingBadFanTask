
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
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        do {
            try checkIfTextfieldsNotEmpty()
        } catch {
            //TODO
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ui.roundCorners(of: buttonLabel, by: 20)
        errorLabel.isHidden = true
        buttonLabel.isEnabled = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        self.textFieldDidBeginEditing(usernameTextfield)
        
    }
    
    
    func checkIfTextfieldsNotEmpty() throws -> Bool {
        if username == usernameTextfield.text,
           password == passwordTextfield.text,
           confirmPassword == confirmPasswordTextfield.text,
           username.isEmpty,
           password.isEmpty,
           confirmPassword.isEmpty {
            throw LoginError.emptyField
        }
        return true
    }
    
    private func hideTextfield( textfield: UITextField?, hide: Bool) {
        textfield?.isHidden = hide
    }
}

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textfield: UITextField) {
        if textfield.text == self.username {
            buttonLabel.isEnabled = true
            print("username textfield tapped")
        }
        if textfield.text == self.password {
            buttonLabel.isEnabled = true
            print("passwod textfield tapped")
        }
        if textfield.text == self.confirmPassword {
            buttonLabel.isEnabled = true
            print("confirm password textfield tapped")
        }
    }
    
    
}
