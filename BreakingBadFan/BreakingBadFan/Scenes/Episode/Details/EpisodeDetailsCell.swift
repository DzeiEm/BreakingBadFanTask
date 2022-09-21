
import Foundation
import UIKit

class EpisodeDetailsCell: UITableViewCell {
    @IBOutlet private weak var charactersLabel: UILabel!
    
    func configureCell(title: String) {
        charactersLabel.text = title
    }
}
