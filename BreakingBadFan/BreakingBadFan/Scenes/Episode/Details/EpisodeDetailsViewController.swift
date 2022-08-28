

import Foundation
import UIKit

class EpisodeDetailsViewController: UIViewController {
    
    @IBOutlet weak var episodeHeader: UILabel!
    @IBOutlet weak var seasonLabel: UILabel!
    @IBOutlet weak var episodeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var episodeTitle: String?
    var episodeNo: String?
    var date: String?
    var seasonNo: String?
    var characters: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCell()
        setupTableView()
        setLabelValues()
    }
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 65
    }
    
    func configureCell() {
        let cellNib = UINib(nibName: "EpisodeDetailsCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "EpisodeDetailsCell")
    }
    func setLabelValues() {
        
        if let episodeNo = episodeNo {
            episodeLabel.text = "EPISODE: \(episodeNo)"
        }
        
        if let episodeTitle = episodeTitle {
            episodeHeader.text = episodeTitle
        }
        if let seasonNo = seasonNo {
            seasonLabel.text = "SEASON: \(seasonNo)"
        }
        if let date = date {
            dateLabel.text = "DATE: \(date)"
        }
        
    }
}

extension EpisodeDetailsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "EpisodeDetailsCell",
                                                 for: indexPath)
        guard let episodeDetailsCell = cell as? EpisodeDetailsCell else {
            return cell
        }
        episodeDetailsCell.configureCell(title: characters[indexPath.row].description)
        print("EPISODE cell: \(characters[indexPath.row].description)")
        return episodeDetailsCell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }
}

extension EpisodeDetailsViewController: UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
}





