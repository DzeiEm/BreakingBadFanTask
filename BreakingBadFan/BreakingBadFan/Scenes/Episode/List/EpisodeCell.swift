
import Foundation
import UIKit

class EpisodeCell: UITableViewCell {
    
    @IBOutlet weak var episodeTitleLabel: UILabel!
    
    
    func configureCell(episodeTitle: String) {
        episodeTitleLabel.text = episodeTitle
    }
}
