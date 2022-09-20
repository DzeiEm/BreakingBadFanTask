

import Foundation
import UIKit
import XCTest


class EpisodeFilterPopoverViewController: UIViewController {
    let apiManager = APIManager()
    var quotes: [Quote] = []
    
    @IBOutlet weak var seasonTextfield: UITextField!
    @IBOutlet weak var fromDateLabel: UILabel!
    @IBOutlet weak var toDateLabel: UILabel!
    @IBOutlet weak var datePicker: UIImageView!
    @IBOutlet weak var tableView: UITableView!

    
    @IBAction func ApplyButtonTapped(_ sender: Any) {
        print("APPLY Button tapped")
    }
    
    override func viewDidLoad() {
        apiManager.getQuotes(completion: { result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let quotes):
                print("QUOTES:\(quotes)")
            }
        })
    }
}

extension EpisodeFilterPopoverViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quotes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let quotCell = tableView.dequeueReusableCell(withIdentifier: "CELLNAME", for: indexPath)
       return quotCell
    }
   
}

extension EpisodeFilterPopoverViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected row tapped")
    }
}


