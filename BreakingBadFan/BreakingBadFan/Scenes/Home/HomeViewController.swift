import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var usernameLabel: UILabel!
   
    
    
    @IBAction func episodesButtonTapped(_ sender: Any) {
        //TODO: - get episodes
    }
    
    @IBAction func charactersButtonTapped(_ sender: Any) {
        //TODO: - get characters
    }
    
    
    @IBAction func quatesButtonTapped(_ sender: Any) {
        //TODO: - get quates
    }
    
    
    override func viewDidLoad() {
        usernameLabel.text = ProfileManager.loggedInAccount?.username
    }
    
}
