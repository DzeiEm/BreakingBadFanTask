

import Foundation
import UIKit

class EpisodeDetailsViewController: UIViewController {
    
    @IBOutlet weak var episodeHeader: UILabel!
    @IBOutlet weak var seasonLabel: UILabel!
    @IBOutlet weak var episodeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    let episodeData = [Episode]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}



