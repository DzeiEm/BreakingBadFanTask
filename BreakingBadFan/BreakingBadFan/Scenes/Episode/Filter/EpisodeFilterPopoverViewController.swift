
import Foundation
import UIKit

class EpisodeFilterPopoverViewController: UIViewController {
    @IBOutlet weak var seasonTextfield: UITextField!
    @IBOutlet weak var fromDateLabel: UILabel!
    @IBOutlet weak var toDateLabel: UILabel!
    @IBOutlet weak var datePicker: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    let apiManager = APIManager()
    var quotes: [Quote] = []
    
    @IBAction func ApplyButtonTapped(_ sender: Any) {
        print("APPLY Button tapped")
    }
    
    override func viewDidLoad() {
        fetchQuotes()
    }
    
    func fetchQuotes() {
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


