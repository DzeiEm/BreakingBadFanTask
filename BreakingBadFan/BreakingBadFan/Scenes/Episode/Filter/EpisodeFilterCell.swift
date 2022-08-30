

import Foundation
import UIKit


class EpisodeFilterCell: UITableViewCell {
    
    @IBOutlet weak var checkIcon: UIImageView!
    @IBOutlet weak var quoteLabel: UILabel!
    
    func configureCell(character: String?) {
        quoteLabel.text = character
    }
}
