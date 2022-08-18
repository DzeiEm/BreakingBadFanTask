import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    var currentUser: Profile?
    var profileManager: ProfileManager!
   

    @IBAction func episodesButtonTapped(_ sender: Any) {
        //TODO: - get episodes
    }
    
    @IBAction func charactersButtonTapped(_ sender: Any) {
        //TODO: - get characters
    }
    
    
    @IBAction func quatesButtonTapped(_ sender: Any) {
        //TODO: - get quates
    }
    
    
    @IBAction func logoutButtonTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        usernameLabel.text = ProfileManager.loggedInAccount?.username
    }
    
}
