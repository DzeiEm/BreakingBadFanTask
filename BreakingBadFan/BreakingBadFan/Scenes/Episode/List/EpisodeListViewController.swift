

import Foundation
import UIKit

class EpisodeListViewController: UITableViewController {
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultCell",
                                                 for: indexPath) // Cell registered in the Main.storyboard
        cell.textLabel?.text = "Some text at row: \(indexPath.row) of section \(indexPath.section)"
        
        
        return cell
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 10
    }
   
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "titleForHeaderInSection"
    }
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected row at: \(indexPath.row)")
    }
    
//    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
//        let allTitles = sectionsArray.map { $0.title }
//        let firstLetters = allTitles.map { String($0.prefix(1)) }
//        
//        return firstLetters
//    }
}
