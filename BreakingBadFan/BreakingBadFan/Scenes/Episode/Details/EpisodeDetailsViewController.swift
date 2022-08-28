

import Foundation
import UIKit

class EpisodeDetailsViewController: UIViewController {
    
    @IBOutlet weak var episodeHeader: UILabel!
    @IBOutlet weak var seasonLabel: UILabel!
    @IBOutlet weak var episodeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
  
    var titleText: String?
    var episodeInformationText: String?
    var airDatetext: String?
    var characters: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        configureCell()
        setupTableView()
    }
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func configureCell() {
        let cellNib = UINib(nibName: "EpisodeDetailsCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "EpisodeDetailsCell")
    }
//    func setupText() {
//
//    })
}

extension EpisodeDetailsViewController: UITableViewDataSource {
  
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EpisodeDetailsCell",
                                                 for: indexPath)
        guard let episodeDetailsCell = cell as? EpisodeDetailsCell else {
            return cell
        }
        episodeDetailsCell.configureCell(title: "CELL")
        return episodeDetailsCell
    }
        
    func numberOfSections(in tableView: UITableView) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
        
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "SOMTHING"
    }

}

extension EpisodeDetailsViewController: UITableViewDelegate {
    

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
}





