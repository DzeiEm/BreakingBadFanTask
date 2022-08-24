
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
    
    let ui = UIAppSettings()
    var profileManager = ProfileManager()
    var loggedinUser = ProfileManager.loggedInAccount
    
    lazy var alert = {
        Bundle.main.loadNibNamed("CustomAlertView", owner: self, options: nil)?.first as? CustomAlertView
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
            //MARK: - REGISTER USER
            do {
                try ProfileManager.register(
                    username: usernameTextfield.text,
                    password: passwordTextfield.text,
                    confirmPassword: confirmPasswordTextfield.text
                )
                if let loggedinUser = ProfileManager.loggedInAccount {

                    
                    let homeSceene = HomeViewController()
                   
                    homeSceene.modalPresentationStyle = .fullScreen
                    present(homeSceene, animated: true, completion: nil)
                    return
                }
                
            } catch let error as AuthenticationError.RegistrationError {
                displayAlert(error: error.localizedDescription)
                
            } catch {
                print(AuthenticationError.General.unexpectedError)
            }
        }
        else {
            //MARK: - LOGIN USER
            do {
                try ProfileManager.login(
                    username: usernameTextfield.text,
                    password: passwordTextfield.text)
                
                guard let loggedinUser = ProfileManager.loggedInAccount else {
                    return
                }
                if loggedinUser.username == ProfileManager.loggedInAccount?.username && loggedinUser.password == ProfileManager.loggedInAccount?.password {
                    
                    let loginViewController = LoginViewController()
                    loginViewController.modalPresentationStyle = .fullScreen
                    navigationController?.pushViewController(loginViewController, animated: true)
                } else {
                    throw AuthenticationError.LoginError.credentialsDoNotMatch
                }
                
            } catch let loginError as AuthenticationError.LoginError  {
                displayAlert(error: loginError.localizedDescription)
                
            }
            catch {
                print(AuthenticationError.General.unexpectedError)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIAppSettings.roundCorners(of: buttonLabel, by: 10)
        UIAppSettings.setButtonColor(button: buttonLabel, color: .purple)
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
    
    static func clearTextfield(_ textfield: UITextField ) {
        textfield.text = ""
    }
}

extension LoginViewController {
    func displayAlert(error: String) {
        
        guard let customAlert = alert else {
            present(AlertView.build(message: error), animated: true)
            return
        }
        customAlert.setupView(
            success: false,
            title: AlertTitle.error.rawValue,
            message: error,
            agreeButtonTitle: AlertButton.ok.rawValue,
            cancelButtonTitle: AlertButton.cancel.rawValue)
        view.addSubview(customAlert)
        
        customAlert.translatesAutoresizingMaskIntoConstraints = false
        customAlert.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        customAlert.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        customAlert.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        customAlert.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
    }
    
}


