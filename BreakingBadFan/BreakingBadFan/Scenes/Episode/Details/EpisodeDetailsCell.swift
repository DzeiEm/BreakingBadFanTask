
import Foundation
import UIKit

class EpisodeDetailsCell: UITableViewCell {
    @IBOutlet weak var charactersLabel: UILabel!
    
    func configureCell(title: String) {
        charactersLabel.text = title
    }
}
