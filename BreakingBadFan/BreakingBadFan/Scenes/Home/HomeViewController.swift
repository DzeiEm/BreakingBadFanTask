import UIKit

class HomeViewController: UIViewController {
    
    var currentUser: Profile?
    var profileManager: ProfileManager!
    
    @IBOutlet private weak var usernameLabel: UILabel!
    @IBOutlet private weak var episodeButton: UIButton!
    @IBOutlet private weak var charactersButton: UIButton!
    @IBOutlet private weak var quotesButton: UIButton!
    
    
    @IBAction func episodesButtonTapped(_ sender: Any) {
        
        let episodeListViewController = EpisodeListViewController()
        episodeListViewController.modalPresentationStyle = .fullScreen
        present(episodeListViewController, animated: true, completion: nil)
    }

    @IBAction func charactersButtonTapped(_ sender: Any) {
        let characterViewController = CharacterViewController()
        characterViewController.modalPresentationStyle = .fullScreen
        present(characterViewController, animated: true, completion: nil)
    }
    
    
    @IBAction func quatesButtonTapped(_ sender: Any) {
        let quotesViewController = QuatesViewController()
        quotesViewController.modalPresentationStyle = .fullScreen
        present(quotesViewController, animated: true, completion: nil)
    }
    
    
    @IBAction func logoutButtonTapped(_ sender: Any) {
        let loginScreen = LoginViewController()
        loginScreen.modalPresentationStyle = .fullScreen
        present(loginScreen, animated: true, completion: nil)
    }
    
    
    override func viewDidLoad()  {
        super.viewDidLoad()
        
        if let username = ProfileManager.loggedInAccount?.username {
            usernameLabel.text = "HI: \(username)"
        }
           
    }
    
    override func viewDidAppear(_ animated: Bool) {
        UIAppSettings.setButtonColor(button: episodeButton, color: .purple)
        UIAppSettings.setButtonColor(button: charactersButton, color: .purple)
        UIAppSettings.setButtonColor(button: quotesButton, color: .purple)
    }
    
}
