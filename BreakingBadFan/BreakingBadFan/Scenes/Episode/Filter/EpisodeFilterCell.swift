
import Foundation
import UIKit

class EpisodeFilterCell: UITableViewCell {
    @IBOutlet private weak var checkIcon: UIImageView!
    @IBOutlet private weak var quoteLabel: UILabel!
    
    func configureCell(character: String?) {
        quoteLabel.text = character
    }
}
