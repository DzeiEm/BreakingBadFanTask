

import Foundation
import UIKit


enum Header: String {
    case quate = "Quate"
}

class QuatesViewController: UITableViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuateCell",
                                                 for: indexPath)
        cell.textLabel?.text = "Some text at row: \(indexPath.row) of section \(indexPath.section)"
        
        if indexPath.row == 0 {
            cell.imageView?.image = UIImage(systemName: "favorite")
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return Header.quate.rawValue
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected row at: \(indexPath.row)")
        
    }
}
