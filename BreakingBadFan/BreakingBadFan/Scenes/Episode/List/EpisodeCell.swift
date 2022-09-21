
import Foundation
import UIKit

class EpisodeCell: UITableViewCell {
    @IBOutlet private weak var episodeTitleLabel: UILabel!
    
    func configureCell(episodeTitle: String) {
        episodeTitleLabel.text = episodeTitle
    }
}
