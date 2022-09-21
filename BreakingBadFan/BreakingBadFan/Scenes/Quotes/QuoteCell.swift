
import Foundation
import UIKit

class QuoteCell: UITableViewCell {
    @IBOutlet private weak var quoteHeader: UILabel!
    
    func configureCell(title: String?) {
        quoteHeader.text = title
    }
}
