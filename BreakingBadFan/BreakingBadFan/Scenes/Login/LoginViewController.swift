
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
    
    let ui = LoginUI()
   
    
    //ACTIONS
    @IBAction func onSegmentControllerTypeChanged(_ sender: UISegmentedControl) {
       
        if registrationTypeSegmentController.selectedSegmentIndex == 0 {
            usernameTextfield.isHidden = false
            passwordTextfield.isHidden = false
            confirmPasswordTextfield.isHidden = false
            errorLabel.isHidden = true
            buttonLabel.titleLabel?.text = SegmentTitle.Register.rawValue
        } else {
            usernameTextfield.isHidden = false
            passwordTextfield.isHidden = false
            confirmPasswordTextfield.isHidden = true
            errorLabel.isHidden = true
            buttonLabel.titleLabel?.text = SegmentTitle.Login.rawValue
        }
        
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        do {
            try checkIfNoEmpty()
        } catch {
            //TODO
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
      ui.roundCorners(of: buttonLabel, by: 20)
        errorLabel.isHidden = true
    }
    
    
    func checkIfNoEmpty() throws {
        guard let username = usernameTextfield.text,
              let password = passwordTextfield.text,
              let confirmPassword  = confirmPasswordTextfield.text,
              username.isEmpty,
              password.isEmpty,
              confirmPassword.isEmpty else  {
            throw LoginError.emptyField
        }
    }
    
    
}
