

import Foundation
import UIKit

class CharacterCell: UITableViewCell {
    
    @IBOutlet weak var characterLabel: UILabel!
    
    func configureCell(title: String)  {
        characterLabel.text = title
    }
    
}
