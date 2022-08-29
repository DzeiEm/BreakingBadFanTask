
import Foundation
import UIKit

enum SegmentTitle: String {
    case Register = "Register"
    case Login = "Login"
}

class LoginViewController: UIViewController {
    
    //MARK: - OUTLETS
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
    
    //MARK: - ACTIONS
    @IBAction func onSegmentControllerTypeChanged(_ sender: UISegmentedControl) {
        
        if registrationTypeSegmentController.selectedSegmentIndex == 0 {
            errorLabel.isHidden = true
            buttonLabel.titleLabel?.text = SegmentTitle.Register.rawValue
            hideTextfield(textfield: usernameTextfield, hide: false)
            hideTextfield(textfield: passwordTextfield, hide: false)
            hideTextfield(textfield: confirmPasswordTextfield, hide: false)
            
        } else {
            errorLabel.isHidden = true
            buttonLabel.titleLabel?.text = SegmentTitle.Login.rawValue
            hideTextfield(textfield: usernameTextfield, hide: false)
            hideTextfield(textfield: passwordTextfield, hide: false)
            hideTextfield(textfield: confirmPasswordTextfield, hide: true)
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
                
            } catch let registrationError as AuthenticationError.RegistrationError {
                displayAlert(error: registrationError.error)
                
            } catch let loginError as AuthenticationError.LoginError {
                displayAlert(error: loginError.error)
                
            }
            catch let securityError as AuthenticationError.Secure {
                displayErrorLabel(message: securityError.error)
                
            } catch let generalError  as AuthenticationError.General {
                displayAlert(error: generalError.error)
            }
            catch {
                print(AuthenticationError.General.unexpectedError)
            }
        }
        else {
            //MARK: - LOGIN USER
            do {
                try ProfileManager.login(
                    username: usernameTextfield.text,
                    password: passwordTextfield.text
                )
                guard let loggedinUser = ProfileManager.loggedInAccount else {
                    return
                }
                if loggedinUser.username == ProfileManager.loggedInAccount?.username &&
                    loggedinUser.password  == ProfileManager.loggedInAccount?.password {
                    
                    let homeSceene = HomeViewController()
                    homeSceene.modalPresentationStyle = .fullScreen
                    present(homeSceene, animated: true, completion: nil)
            
                }
            } catch let loginError as AuthenticationError.LoginError  {
                displayAlert(error: loginError.error)
                
            } catch let generalError as AuthenticationError.General {
                displayAlert(error: generalError.error)
                
            } catch {
                displayAlert(error:AuthenticationError.General.unexpectedError.error)
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
        buttonLabel.isEnabled = true
        return true
    }
    
    private func hideTextfield( textfield: UITextField?, hide: Bool) {
        textfield?.isHidden = hide
    }
    
    private func clearTextfield(_ textfield: UITextField ) {
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
    
    func displayErrorLabel(message: String) {
        errorLabel.isHidden = false
        errorLabel.textColor = .red
        errorLabel.text = message
    }
    
}


